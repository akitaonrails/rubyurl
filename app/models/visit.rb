class Visit
  include DataMapper::Resource
  
  property :id, Serial
  property :link_id, Integer, :required => true
  property :referral_link, Text
  property :flagged, String
  property :ip_address, String, :length => 20
  timestamps :at

  belongs_to :link
end
