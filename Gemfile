source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'].to_s : ['~> 4.0']
gem 'puppet', puppetversion, :require => false, :groups => [:test]
gem 'puppet-lint', '>= 1.0.0'
gem 'facter', '~> 2.4'
# gem 'rspec-puppet'
# gem 'rspec-puppet-facts', '~> 1.7', :require => false

# rspec must be v2 for ruby 1.8.7
if RUBY_VERSION >= '1.8.7' && RUBY_VERSION < '1.9'
  gem 'rspec', '~> 2.0'
  gem 'rake', '~> 10.0'
else
  # rubocop requires ruby >= 1.9
  gem 'rubocop'
end

group :test do
  gem 'coveralls',                                                      require: false if RUBY_VERSION >= '2.0.0'
  gem 'json_pure', '<= 2.0.1',                                          require: false if RUBY_VERSION < '2.0.0'
  gem 'metadata-json-lint',                                             require: false
  gem 'mocha', '>= 1.2.1',                                              require: false
  gem 'puppet-blacksmith', '>= 3.4.0',                                  require: false
  gem 'puppet-lint-absolute_classname-check',                           require: false
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check',      require: false
  gem 'puppet-lint-leading_zero-check',                                 require: false
  gem 'puppet-lint-trailing_comma-check',                               require: false
  gem 'puppet-lint-unquoted_string-check',                              require: false
  gem 'puppet-lint-variable_contains_upcase',                           require: false
  gem 'puppet-lint-version_comparison-check',                           require: false
  gem 'puppet-strings', '~> 0.99.0',                                    require: false
  gem 'puppetlabs_spec_helper', '~> 1.2.2',                             require: false
  gem 'rspec-puppet', '~> 2.5',                                         require: false
  gem 'rspec-puppet-facts',                                             require: false
  gem 'rspec-puppet-utils',                                             require: false
  gem 'rubocop-rspec', '~> 1.6',                                        require: false if RUBY_VERSION >= '2.3.0'
  gem 'simplecov-console',                                              require: false if RUBY_VERSION >= '2.0.0'
end