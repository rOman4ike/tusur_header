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
  s.add_development_dependency 'rails', '~> 3.2.15'
  s.add_development_dependency 'bootstrap-sass', '~> 3.1.1'
  s.add_development_dependency 'coffee-rails', '~> 3.2.2'
  s.add_development_dependency 'compass-rails', '~> 1.1.3'
  s.add_development_dependency 'jquery-rails', '~> 2.1.4'
  s.add_development_dependency 'sass-rails', '>= 3.2'

  s.add_runtime_dependency 'bootstrap-sass', '~> 3.1.1'
  s.add_runtime_dependency 'coffee-rails', '~> 3.2.2'
  s.add_runtime_dependency 'compass-rails', '~> 1.1.3'
  s.add_runtime_dependency 'jquery-rails', '~> 2.1.4'
  s.add_runtime_dependency 'sass-rails', '~> 3.2.6'

  s.rubyforge_project = s.name
end
