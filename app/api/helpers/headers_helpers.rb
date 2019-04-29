module HeadersHelpers

  def self.included(entity)
    unless entity.name.nil? # NOTE: don't care about anonymous classes and modules
      entity.class_eval {abstract_method(:headers)}
    end
  end

  def header_client_zipcode
    @header_client_zipcode ||= headers["X-NL-#{header_client_platform}-Client-Location-Zipcode"]
  end

  def header_client_id
    @header_client_id ||= headers["X-NL-#{header_client_platform}-Client-Id"]
  end

  def header_client_version
    @header_client_version ||= headers["X-NL-#{header_client_platform}-Client-Version"]
  end

  def header_client_latitude
    @header_client_latitude ||= headers["X-NL-#{header_client_platform}-Client-Location-Lat"]
  end

  def header_client_longitude
    @header_client_longitude ||= headers["X-NL-#{header_client_platform}-Client-Location-Lon"]
  end

  def header_user_agent
    @header_user_agent ||= headers['User-Agent']
  end

  def header_client_search_id
    @header_client_search_id ||= headers["X-NL-#{header_client_platform}-Search-Id"]
  end

  def header_client_platform
    @header_client_platform ||= begin
      case
      when headers['X-NL-Ios-Client-Id']
        Client.platforms.ios
      when headers['X-NL-Android-Client-Id']
        Client.platforms.android
      when headers['X-NL-Web-Client-Id']
        Client.platforms.web
      end
    end
  end

end
