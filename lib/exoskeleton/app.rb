require 'pathname'
module Exoskeleton
  class App
    def self.initialize!(path=nil)
      @lib_root = @root = Pathname.new(File.expand_path('../../../',__FILE__))
      
      @app_root = path ? Pathname.new(path) : @lib_root + "public"
    end

    def self.exoskeleton
      root + 'public/exoskeleton.json'
    end

    def self.assets
      Assets.new #reload on each request.
    end

    def self.root
      @root || initialize! and @root
    end

    def self.app_root
      @app_root || initialize! and @app_root
    end

    def self.public_path
      app_root
    end

    def self.view_path
      root + 'app/views'
    end

    def self.env
      @env ||= ENV['RACK_ENV'] || "development"
    end
  end
end


