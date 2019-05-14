source 'https://rubygems.org'

ruby '2.6.2'

# dotenv rails hook must go first
# loading immediately so that other gems have access.
gem 'dotenv-rails', require: 'dotenv/rails-now'

gem 'rails'
gem 'rails-api'
gem 'pg'
gem 'groupdate' # MC stats fetching
gem 'acts-as-taggable-array-on'

gem 'rack-cors'

gem 'hash_dot'
gem 'grape'  #git: 'https://github.com/ruby-grape/grape.git'
gem 'grape-rabl'
gem 'grape-swagger'
gem 'grape-swagger-rails'

gem 'grape-rails-cache', git: 'https://github.com/altincicadde/grape-rails-cache'
gem 'dalli-elasticache'

gem 'interactor-rails'
gem 'abstract_method'

gem 'hashie-forbidden_attributes'
gem 'state_machines-activerecord'
gem 'state_machines-audit_trail'
gem 'paper_trail', '~> 4.1.0'

# gem 'newrelic_rpm'
# gem 'newrelic-grape'

gem 'gibberish'
gem 'bcrypt', require: 'bcrypt'
gem 'sitemap_generator'

# Prior to a lot of 3.0 stuff which is much heavier
gem 'aws-sdk-s3'
gem 'houston'

gem 'rest-client'
gem 'twilio-ruby'
gem 'send_with_us'
gem 'slack-notifier'

gem 'omniauth-facebook'
gem 'omniauth-linkedin'
gem 'ruby-saml'

gem 'foreman'
gem 'geocoder'
gem 'fastimage', require: false

gem 'addressable'

gem 'redis'
gem 'connection_pool'

# PERSISTENCE

gem 'rom-csv', git: 'https://github.com/rom-rb/rom-csv', require: false

# BACKGROUND PROCESSING

# INFO: https://github.com/chaps-io/gush
#       Fast and distributed workflow runner using only Sidekiq and Redis

gem 'sidekiq'
gem 'sidekiq-cron'
gem 'sidekiq-status'
gem 'sinatra', require: false

gem 'searchkick'
gem 'searchjoy'
gem 'typhoeus'

# ANALYZERS

gem 'rollbar'

group :production, :integration do
  gem 'unicorn', '~> 4.8.3'
  gem 'unicorn-worker-killer'
end

group :development do
  gem 'ruby-debug-ide', require: false
  gem 'debase', require: false
  gem 'thin'
  gem 'terminal-notifier', require: false
  gem 'ruby-graphviz', require: false
  gem 'better_errors'
  gem 'binding_of_caller', platforms: [:ruby_22]
  gem 'httplog'
  gem 'bullet'
  # gem 'spring', require: false
  # gem 'spring-commands-rspec', require: false
end

group :development, :test do
  gem 'bundler-audit'
  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'capistrano-rbenv-install'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'slackistrano', require: false
  gem 'parallel_tests'
  gem 'airbrussh', require: false
  gem 'dotenv', require: false
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
  gem 'json-schema'
  gem 'factory_bot_rails', require: false # Do not require it for lightweight spec helpers
  gem 'database_cleaner'
  gem 'database_rewinder' # TODO: replace above gem with it
  gem 'nokogiri' # used by custom have_xpath RSpec matcher
  gem 'webmock'
  gem 'test_after_commit'
  gem 'fakeredis', require: 'fakeredis/rspec'
end

group :test do

  # CI & ANALYZERS
  gem 'ci_reporter', '~> 2.0.0', git: 'https://github.com/ci-reporter/ci_reporter'
  gem 'ci_reporter_rspec', '~> 1.0.0', git: 'https://github.com/ci-reporter/ci_reporter_rspec'
  gem 'metric_fu', require: false
  gem 'pronto', require: false
  # gem 'pronto-brakeman', require: false
  gem 'pronto-fasterer', require: false
  gem 'pronto-rails_schema', require: false
  gem 'pronto-rubocop', require: false
  gem 'pronto-rails_best_practices', require: false
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
end

gem "grape-kaminari"

gem "kaminari-grape"

gem "graphviz"

gem 'api-pagination'

gem 'redis-namespace'
