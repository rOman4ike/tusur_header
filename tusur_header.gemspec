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
  s.add_dependency 'rails', '>= 4.0', '< 6.0'
  s.add_dependency 'tusur_cdn'

  s.add_runtime_dependency 'configliere'
  s.add_runtime_dependency 'rest-client'

  s.rubyforge_project = s.name
end
