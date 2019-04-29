class API < Grape::API
  logger Rails.logger

  helpers do
    def logger
      API.logger
    end
  end

  helpers UserHelpers
  helpers HeadersHelpers
  helpers ParamsHelpers
  helpers ContentTypeHelper

  before do
    user = current_user || current_guest_user

  end

  format :json

  formatter :json, ->(object, env) do
    (object.is_a?(String) && object.length > 24) ? object : Grape::Formatter::Rabl.call(object, env)
  end

  default_format :json
  default_error_status 400

  rescue_from ActiveRecord::RecordNotFound do |e|
    Rollbar.error(e)
    error!({message: e.message, id: "rocket_internal_error"}, 400, {'Content-Type' => 'api/error'})
  end

  rescue_from :all do |e|
    # TODO: Implement error handler implementations here
    # NewRelic::Agent.notice_error(e)
    error_info = "#{e.message}\n\n#{e.backtrace.join("\n")}"
    # API.logger.error error_info
    puts error_info if ENV['TEST_DEBUG']
    # Rollbar.error(e)
    error!({message: e.message, id: "rocket_internal_error"}, 400, {'Content-Type' => 'api/error'})
  end

  mount ::NL::AppV2

  # Handling 404
  # It is very crucial to define this endpoint at the very end of your API, as it literally accepts every request.
  route :any, '*path' do
    request_data = {
        method: env['REQUEST_METHOD'],
        path: env['PATH_INFO'],
        query: env['QUERY_STRING']
    }
    logger.error "[api] Path not found: #{request_data}"
    error!({message: 'No such endpoint.', id: 'missing_endpoint'}, 404, {'Content-Type' => 'api/error'})
  end
end

