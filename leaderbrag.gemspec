# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'leaderbrag/version'
Gem::Specification.new do |spec|
  spec.name          = 'leaderbrag'
  spec.version       = Leaderbrag::VERSION
  spec.authors       = ['David Schlenk']
  spec.email         = ['david@schdav.org']

  spec.summary       = 'Find out if your baseball team is best baseball team.'
  spec.description   = 'Tools to determine whether a baseball team is leading'\
   'its division/league/all of baseball.'
  spec.homepage      = 'https://github.com/schlazor/leaderbrag'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = spec.homepage
    spec.metadata['changelog_uri'] = 'https://github.com/dschlenk/leaderbrag/tree/master/CHANGELOG.md'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'thor', '~> 0.20'
  spec.add_development_dependency 'aruba', '~> 0.14'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'cucumber', '~> 3.1'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'rubocop', '~> 0.71'
  spec.add_development_dependency 'thor', '~> 0.20'
end
