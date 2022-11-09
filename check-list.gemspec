# frozen_string_literal: true

require_relative './lib/version'

Gem::Specification.new do |s|
  s.name        = 'check-list'
  s.version     = Checklist::Version.version
  s.summary     = ''
  s.description = 'A cppb checklist'
  s.authors     = ['Kyle Swaffield']
  s.email       = 'kyle@swaff.iu.au'
  s.files       = ['lib/check-list.rb', 'lib/check-list.yml', 'lib/version.rb']
  s.homepage    = 'https://rubygems.org/gems/check-list'
  s.license     = 'MIT'
  s.executables << 'check-list'
  s.required_ruby_version = '>= 2.6'
end
