require "rubygems"
require "bundler/setup"

# require your gems as usual
require "sinatra"
require "haml"
require 'json'
require 'coffee-script'
require 'closure-compiler'

require 'v8'

require "lib/exoskeleton"

# run app
run Exoskeleton::Server
