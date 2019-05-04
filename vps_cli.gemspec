# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vps_cli/version'

Gem::Specification.new do |spec|
  spec.name          = 'vps_cli'
  spec.version       = VpsCli::VERSION
  spec.authors       = ['paramagicdev']
  spec.email         = ['konnor5456@gmail.com']

  spec.summary       = 'A gem created to facilitate setup of a new dev server'
  spec.homepage      = 'https://github.com/ParamagicDev/vps_cli'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata['homepage_uri'] = 'https://github.com/ParamagicDev/vps_cli'
    spec.metadata['source_code_uri'] = 'https://github.com/ParamagicDev/vps_cli'
    spec.metadata['changelog_uri'] = 'https://github.com/ParamagicDev/vps_cli'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'guard', '~> 2.15'
  spec.add_development_dependency 'guard-minitest', '~> 2.4'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_runtime_dependency 'thor', '~> 0.20'
end
