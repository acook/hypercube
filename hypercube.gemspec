# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hypercube/version'

Gem::Specification.new do |gem|
  gem.name          = 'hypercube'
  gem.version       = Hypercube::VERSION
  gem.authors       = ['Anthony Cook']
  gem.email         = ['anthonymichaelcook@gmail.com']
  gem.description   = %q{A virtual machine manager that doesn't suck as much as doing everything manually.}
  gem.summary       = %q{Virtual machine management that doesn't suck (as much).}
  gem.homepage      = 'http://github.com/acook/hypercube'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'systemu'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'pry-theme'
end
