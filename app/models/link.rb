class Link 
  include DataMapper::Resource
  
  property :id,          Serial
  property :website_url, String, :required => true, :length => (10..500)
  property :token,       String
  property :permalink,   String
  property :ip_address,  String, :required => true
  timestamps :at
  
  TOKEN_LENGTH = 4
  attr_accessor :http_host
  
  has n, :visits
  has n, :spam_visits, :model => 'Visit', :flagged => 'spam'
  
  validates_is_unique :website_url
  validates_is_unique :token  
  validates_format :website_url, :with => /^(http|https):\/\/[a-z0-9]/ix, :on => :save, :message => 'needs to have http(s):// in front of it', :if => Proc.new { |p| p.website_url? }
  
  before :create, :generate_token
  
  def self.find_or_create_by_website_url(website_url)
    sites = Link.all(:website_url => website_url)
    return sites.first unless sites.empty?
    Link.create(:website_url => website_url)
  end
  
  def flagged_as_spam?
    self.spam_visits.empty? ? false : true
  end
  
  def add_visit(request)
    visit = visits.build(:ip_address => request.remote_ip)
    visit.save
    return visit
  end

  def to_api_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.link do
      xml.tag!( :website_url, self.website_url )
      xml.tag!( :permalink, self.permalink )
    end
  end
  
  def to_api_json
    self.to_json( :only => [ :website_url, :permalink ] )
  end
  
  private
  
    def generate_token
      if (temp_token = random_token) and self.class.all(:token => temp_token).empty?
        self.token = temp_token
        build_permalink
      else
        generate_token
      end
    end
    
    def build_permalink
      self.permalink = "http://#{http_host}/" + self.token
    end
  
    def random_token
      characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890'
      temp_token = ''
      srand
      TOKEN_LENGTH.times do
        pos = rand(characters.length)
        temp_token += characters[pos..pos]
      end
      temp_token
    end
end

