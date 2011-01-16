require 'thor'
module Exoskeleton
  class CLI < Thor
    include Thor::Actions

    def initialize(*)
      puts "starting"
      super
    end

    desc "help", "help stuff"
    def help
      puts "HELP HELP HELP"
    end

    desc "server", "boot server"
    def server
      puts "run server on this file"
      Exoskeleton::AppServer.run_self_contained
    end

    desc "generate", "generate assets"
    def generate
      puts "generate stuff"
    end

    desc "new", "create new app"
    def new
      puts "generate a new app"
    end
  end
end
