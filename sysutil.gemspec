# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sysutil/version/version'

Gem::Specification.new do |spec|
  spec.name          = "sysutil"
  spec.version       = Sysutil::VERSION
  spec.authors       = ["Chris Watson"]
  spec.email         = ["cawatson1993@gmail.com"]

  spec.summary       = "Control linux with ruby"
  spec.description   = "Library that acts as a wrapper for various linux commands"
  spec.homepage      = "http://cwatsondev.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
