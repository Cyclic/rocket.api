if Rails.env.development?
  ActiveSupport::Dependencies.explicitly_unloadable_constants << 'API::App'

  api_files = Dir[Rails.root.join('app', 'api', '**', '*.rb')]
  api_reloader = ActiveSupport::FileUpdateChecker.new(api_files) do
    Rails.application.reload_routes!
  end
end
