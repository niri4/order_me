
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "order_me/version"

Gem::Specification.new do |spec|
  spec.name          = "order_me"
  spec.version       = OrderMe::VERSION
  spec.authors       = ["niri4"]
  spec.email         = ["nirankarsingh247@gmail.com"]

  spec.summary       = %q{ Write a short summary, because RubyGems requires one.}
  spec.description   = %q{ Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/niri4/order_me"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = " Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency 'kaminari', '>= 1.0.1'
  spec.add_dependency 'jquery-rails'
  spec.add_dependency 'bootstrap-sass', '~> 3.3', '>= 3.3.6'
  spec.add_dependency 'carrierwave', '~> 1.0'
end
