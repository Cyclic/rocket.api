# ABOUT: Trying to load only what is needed to semi-unit specs, taking
# best of Rails (like spring, autoloading, etc).
# Actually, I believe we can switch to this helper in the future, 'cause booting
# one test for 6-9 secs is killing the meaning of testing...
# RESULTS: Simple test suite loads/runs < 1 sec

# NOTE: This is draft spec helper, need to test it more
# We don't need spec_helper here, since it sets defaults anyway

ENV['RAILS_ENV'] ||= 'test'

# App root
$:.unshift(File.expand_path('../../', __FILE__))

# DATABASE REWINDER

# NOTE: Make sure what you required database_rewinder before rails run,
# 'cause it adds DB init hook, which will not run if we'd require gem later.

# RAILS

require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

#
# GEMS
#

# Do not require everything in "factories" directory by using 'factory_bot'
# instead of 'factory_bot_rails' which is does it automatically
require 'factory_bot'
require 'rspec/rails'

# You can temporary allow network connection with NetworkConnection.allow_network_connections!
require 'support/network_connection'

# Sidekiq provides the following three testing modes:
# - A test fake that pushes all jobs into a jobs array
# - An inline mode that runs the job immediately instead of enqueuing it
# - The test harness can be disabled. Jobs are pushed to redis.
# Remember: you can use blocks to temporary switch mode

require 'sidekiq/testing'
Sidekiq::Testing.fake!

#
# GRAPE RELOADING
#

# TODO: Make sure we do need this
# Also, @see https://github.com/ruby-grape/grape/issues/131#issuecomment-4534822
# Dir["#{Rails.root}/lib/api/**/*.rb"].map { |f| load f }
# Also, maybe we do not need test.rb/config.cache_classes = false

#
# SUPPORT FILES
#

# Pick only what you need
require_relative 'support/tasks'
require_relative 'support/twilio'

#
# FACTORY GIRL
#

require_relative 'factories/twilio_number'

# Do not load FG dir at all
FactoryBot.definition_file_paths = []

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseRewinder['test']
    DatabaseRewinder['harvester_test']

    DatabaseRewinder.clean_all
  end

  config.after(:each) do
    DatabaseRewinder.clean
  end

  config.include FactoryBot::Syntax::Methods
  config.include ActiveSupport::Testing::TimeHelpers
end
