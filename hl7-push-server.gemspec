# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hl7-push-server/version'

Gem::Specification.new do |spec|
  spec.name          = "hl7-push-server"
  spec.version       = HL7PushServer::VERSION
  spec.authors       = ["Simon Kaluza"]
  spec.email         = ["kaluza.simon@gmail.com"]
  spec.summary       = %q{Simple HL7 server that generates fake messages to push to connected clients}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_dependency 'ruby-hl7'
end
