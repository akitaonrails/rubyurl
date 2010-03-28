ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'links'
  map.resources :links, :name_prefix => 'api_', :path_prefix => 'api', :controller => 'api/links'  
      
  map.with_options :controller => "links" do |link|
    link.connect 'rubyurl/remote', :action => 'create'

    link.connect 'about',          :action => 'about'
    link.connect 'api',            :action => 'api'
    link.connect 'report-abuse',   :action => 'report'
    link.connect 'home',           :action => 'home'  

    link.connect ':token',         :action => 'redirect'
  end

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
