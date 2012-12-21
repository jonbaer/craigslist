# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ['Greg Stallings']
  gem.email         = ['gregstallings@gmail.com']
  gem.description   = %q{Unofficial Ruby interface for programmatically accessing Craigslist listings.}
  gem.summary       = %q{Unofficial Ruby interface for programmatically accessing Craigslist listings.}
  gem.homepage      = 'https://github.com/gregstallings/craigslist'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'craigslist'
  gem.require_paths = ['lib']
  gem.version       = '0.0.3'

  gem.add_dependency 'rake'
  gem.add_dependency 'rspec'
  gem.add_dependency 'nokogiri'
end
