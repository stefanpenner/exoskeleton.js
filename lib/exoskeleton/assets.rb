require 'active_support/core_ext/array/wrap'
require 'json'

module Exoskeleton
  class Assets
    attr_accessor :paths
    include FileUtils

    def initialize
      @paths = Hash.new([])

      exo = Hash.new([])
      exo.merge! JSON.parse(open(Exoskeleton::App.exoskeleton).read)
      
      libs  = exo['lib'].collect         { |file| "lib/#{file}"             }
      libs += exo['boot'].collect        { |file| "config/#{file}"          }
      libs += exo['models'].collect      { |file| "app/models/#{file}"      }
      libs += exo['helpers'].collect     { |file| "app/helpers/#{file}"     }
      libs += exo['views'].collect       { |file| "app/views/#{file}"       }
      libs += exo['controllers'].collect { |file| "app/controllers/#{file}" }
      
      libs.each do |lib|
        lib =~ /\.([^\.]+)$/
        send $1, lib
      end
    end

    def add(type,*files)
      @paths[type] = @paths[type] | Array.wrap(files).flatten
    end

    def method_missing(method,*data)
      if not data.nil?
        add method, data
      elsif @paths.keys.include?(method)
        @paths[method]
      else
        super
      end
    end
  end
end
