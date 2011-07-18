# -*- encoding: utf-8 -*-
require File.expand_path('../lib/crash_hook/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'crash_hook'
  gem.version     = CrashHook::VERSION.dup
  gem.author      = 'Dan Sosedoff'
  gem.email       = 'dan.sosedoff@gmail.com'
  gem.homepage    = 'https://github.com/sosedoff/crash_hook'
  gem.summary     = %q{Exception notifications via HTTP}
  gem.description = %q{Rack middleware to notify HTTP endpoint with application notifications}

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rack', '~> 1.2'
  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'simplecov', '~> 0.4'
  gem.add_development_dependency 'fakeweb', '~> 1.3'

  gem.add_runtime_dependency 'rest-client', '~> 1.6'
  gem.add_runtime_dependency 'multi_json', '~> 1.0'
end