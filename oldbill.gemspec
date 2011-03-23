# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "oldbill/version"

Gem::Specification.new do |s|
  s.name        = "oldbill"
  s.version     = Oldbill::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["hookercookerman"]
  s.email       = ["hookercookerman@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{ruby wrapper for the police API}
  s.description = %q{ruby wrapper for the police API}

  s.rubyforge_project = "oldbill"
  
  s.add_dependency 'activesupport',    '~> 3.0.5'
  s.add_dependency 'i18n',             '>= 0.5'
  s.add_dependency 'httparty',         '~> 0.7.4'
  s.add_dependency 'hashie',           '~> 1.0.0'
  s.add_dependency 'moneta',           '~> 0.6.0'
  s.add_dependency 'tzinfo',           '~> 0.3.22'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
