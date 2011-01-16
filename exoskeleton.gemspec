# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "exoskeleton/version"

Gem::Specification.new do |s|
  s.name        = "exoskeleton"
  s.version     = Exoskeleton::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Stefan Penner"]
  s.email       = ["Stefan.Penner@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{somasf somasdf}
  s.description = %q{mog mog mog}

  s.rubyforge_project = "exoskeleton"

  s.add_dependency 'coffee-script'
  s.add_dependency 'json'
  s.add_dependency 'sinatra'
  s.add_dependency 'haml'
  s.add_dependency 'thor'
  s.add_dependency 'rack'
  s.add_dependency 'activesupport', '3.0.3'
  s.add_dependency 'closure-compiler'
  s.add_dependency 'therubyracer'
  s.add_development_dependency 'ruby-debug'
  s.add_development_dependency 'racksh'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
