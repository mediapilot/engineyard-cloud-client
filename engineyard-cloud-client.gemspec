# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'engineyard-cloud-client/version'

Gem::Specification.new do |s|
  s.name = "engineyard-cloud-client"
  s.version = EY::CloudClient::VERSION
  s.platform = Gem::Platform::RUBY
  s.author = "EY Cloud Team"
  s.email = "cloud@engineyard.com"
  s.homepage = "http://github.com/engineyard/engineyard-cloud-client"
  s.summary = "EY Cloud API Client"
  s.description = "This gem connects to the EY Cloud API"

  s.files = Dir.glob("{lib}/**/*") + %w(LICENSE README.rdoc)
  s.require_path = 'lib'

  s.rubygems_version = %q{1.3.6}
  s.test_files = Dir.glob("spec/**/*")

  s.add_dependency('rest-client', '~>1.6.0')
  s.add_dependency('json_pure')
  s.add_dependency('launchy', '2.0.5')

  s.add_development_dependency('rspec', '~>2.0')
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('fakeweb')
  s.add_development_dependency('fakeweb-matcher')
  s.add_development_dependency('sinatra')
  s.add_development_dependency('realweb', '~>0.2.2')
end