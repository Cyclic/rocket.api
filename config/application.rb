require File.expand_path('../boot', __FILE__)
require File.expand_path('../../app/services/config_service', __FILE__)

require 'active_record/railtie'
require 'grape/rabl'

require 'grape/rails/cache'
require 'dalli/elasticache'
require 'active_job/railtie'
require 'sprockets/railtie'

require 'grape-kaminari'

require 'hash_dot'
Hash.use_dot_syntax = true

Bundler.require(*Rails.groups)

module NeutrinoLabsApi
  class Application < Rails::Application


    # Auto-load API and its subdirectories
    # config.paths.add 'app/api', glob: '**/*.rb'
    config.autoload_paths += [Rails.root]
    config.autoload_paths += [Rails.root.join('app')]
    config.autoload_paths += Dir["#{Rails.root}/app/models"]
    config.autoload_paths += Dir["#{Rails.root}/app/api/**/"]
    config.autoload_paths += Dir["#{Rails.root}/app/services/*"]

    config.time_zone = 'America/Los_Angeles'
    config.beginning_of_week = :monday
    Groupdate.week_start = :mon

  end
end
