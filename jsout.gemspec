# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jsout/version'

Gem::Specification.new do |spec|
  spec.name          = "jsout"
  spec.version       = Jsout::VERSION
  spec.authors       = ["alse"]
  spec.email         = ["al.se@me.com"]
  spec.description   = %q{Json presenters for your models}
  spec.summary       = %q{Json presenters for your models}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "> 1.3"
  spec.add_development_dependency "rails", "> 3.2.13"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3-ruby"
  spec.add_dependency "activerecord", "> 3.2.13"
end
