# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra_permitted_params/version'

Gem::Specification.new do |spec|
  spec.name          = 'sinatra_permitted_params'
  spec.version       = SinatraPermittedParams::VERSION
  spec.authors       = ['peerTransfer tech']
  spec.email         = ['tech@peertransfer.com']
  spec.summary       = %q{A sinatra gem to filter params}
  spec.description   = %q{A sinatra gem to filter params}

  files = Dir['lib/*.rb'] + Dir['lib/**/*.rb']
  rootfiles = ['Gemfile', 'sinatra_permitted_params.gemspec', 'README.md']
  dotfiles = ['.gitignore']

  spec.files         = files + rootfiles + dotfiles
  spec.test_files    = Dir['spec/*.rb'] + Dir['spec/**/*.rb']
  spec.require_paths = ['lib']


  spec.add_development_dependency 'sinatra', '~> 1.3'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rack-test'
end
