require 'sinatra'
require 'coffee-script'

module Exoskeleton
  class Server < Sinatra::Base
    set :views, App.view_path
    mime_type :coffee, 'text/javascript'

    def sanitize_path(path)
      App.public_path + path.gsub(/^\//,'')
    end
    
    get '/app/all.js' do
      raw = App.assets.coffee.inject("") do |code,file|
        code << open(App.public_path + file).read
        code
      end

      CoffeeScript.compile raw
    end

    get '/' do
      assets = Assets.new
      @javascripts = assets.js + assets.coffee
      haml :index
    end

    get /\/(.+\.(\w+))$/ do |path,ext|

      path = sanitize_path(path)

      return 404 unless File.exists? path

      file = open(path)

      case ext
      when /coffee/ then 
        content_type :js
        CoffeeScript.compile file.read
      else
        file.read
      end
    end
  end
end
