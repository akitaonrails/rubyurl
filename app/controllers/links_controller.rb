class LinksController < ApplicationController  
  def index  
    redirect_to '/home'
  end
  
  def home
    @link = Link.new
    render :action => 'index'
  end

  def create
    website_url = params.include?(:website_url) ? params[:website_url] : params[:link][:website_url]
    @link = Link.find_or_create_by_website_url( website_url )
    @link.http_host = request.env["HTTP_HOST"]
    @link.ip_address = request.remote_ip if @link.new_record?
    
    if @link.save
      render :action => :show
    else
      flash[:warning] = 'There was an issue trying to create your RubyURL.'
      redirect_to :action => :invalid
    end
  end

  def redirect
    @link = Link.all(:token => params[:token]).first

    unless @link.nil?
      @link.add_visit(request)
      website_url = @link.website_url.starts_with?("http://") ? @link.website_url : "http://#{@link.website_url}"
      redirect_to website_url, { :status => 301 }
    else
      redirect_to :action => 'invalid'
    end
  end
end
