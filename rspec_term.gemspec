# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec_term/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec_term"
  spec.version       = RspecTerm::VERSION
  spec.authors       = ["brightgenerous"]
  spec.email         = ["katou.akihiro@gmail.com"]
  spec.summary       = %q{iTerm with RSpec}
  spec.description   = %q{Change iTerm background after RSpec execution.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject{ |f| f.start_with?('images') }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
