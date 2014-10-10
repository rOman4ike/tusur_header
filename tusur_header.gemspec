$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'tusur_header/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'tusur_header'
  s.version     = TusurHeader::VERSION
  s.authors     = ['Evgeny Lapin']
  s.email       = ['lev@openteam.ru']
  s.homepage    = ''
  s.summary     = ''
  s.description = ''

  s.files = `git ls-files`.split("\n")

  s.add_development_dependency 'bundler'
  s.add_dependency 'rails', '~> 4.0'

  s.add_runtime_dependency 'bootstrap-sass', '~> 3.1.1'
  s.add_runtime_dependency 'coffee-rails'
  s.add_runtime_dependency 'compass-rails'
  s.add_runtime_dependency 'jquery-rails'
  s.add_runtime_dependency 'sass-rails', '>= 3.2'
  s.add_runtime_dependency 'rest-client'
  s.add_runtime_dependency 'stop_ie', '>= 0.1.5'

  s.rubyforge_project = s.name
end
