Gem::Specification.new do |spec|
  spec.name          = "reloop"
  spec.version       = "0.1.0"
  spec.authors       = ["Reloop Labs"]
  spec.email         = ["support@reloop.sh"]
  spec.summary       = "Reloop Ruby SDK"
  spec.description   = "Reloop Ruby SDK for interacting with the Reloop API"
  spec.homepage      = "https://reloop.sh"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"]
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 2.0"
  spec.add_dependency "json", "~> 2.0"

  spec.add_development_dependency "minitest", "~> 5.0"
end
