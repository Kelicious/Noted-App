Noted::Application.routes.draw do

  # rake assets:precompile (among other tasks) get hella broken here if 
  # application.js/css don't exist yet
  begin
    offline = Rack::Offline.configure :cache => true do   
      cache ActionController::Base.helpers.asset_path("application.js")
      cache ActionController::Base.helpers.asset_path("application.css")
      
      cache "assets/fontawesome-webfont.eot?v=3.0.2"
      cache "assets/fontawesome-webfont.eot?#iefix&v=3.0.2"
      cache "assets/fontawesome-webfont.woff?v=3.0.2"
      cache "assets/fontawesome-webfont.ttf?v=3.0.2"

      network "*"  
    end
    match "/application.appcache" => offline  
  rescue
    puts "skipped configuring offline cache"
  end

  root :to => 'assets#index'
end
