require 'rack'
module Exoskeleton
  class AppServer < ::Rack::Server
    def app
      options[:app]
    end

    alias wrapped_app app

    def self.run_self_contained
      start :app => Server, :host => '0.0.0.0', :Port => 9293
    end
  end
end
