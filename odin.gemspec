# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "odin/version"

Gem::Specification.new do |s|
  s.name        = "odin"
  s.version     = Odin::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Benjamin Oakes"]
  s.email       = ["hello@benjaminoakes.com"]
  s.homepage    = "http://github.com/benjaminoakes/odin"
  s.summary     = %q{An ATN-based parser for human languages, such as English.}
  s.description = s.summary

  s.rubyforge_project = "odin"
  s.add_dependency('activesupport', '~> 2.0.1')
  s.add_dependency('english', '~> 0.1')
  s.add_dependency('facets', '~> 2.2.1')
  s.add_dependency('linguistics', '~> 1.0.8')

  s.add_development_dependency('rake', '~> 0.8.7')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
