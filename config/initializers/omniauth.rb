Rails.application.config.middleware.use Rack::Session::Cookie, secret: ENV['RACK_SESSION_COOKIE_SECRET']
Rails.application.config.middleware.use OmniAuth::Builder do
  configure do |config|
    config.path_prefix = '/v2/auth'
  end
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], {provider_ignores_state: true}
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'], {provider_ignores_state: true}
end
