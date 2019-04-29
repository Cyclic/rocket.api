require 'webmock/rspec'

module NetworkConnection
  require 'open-uri'

  def self.disable_network_connections!
    WebMock.allow_net_connect!
  end

  def self.enable_network_connections!
    # from https://github.com/bblimke/webmock
    #
    # HTTP protocol has 3 steps: connect, request and response (or 4 with
    # close). Most Ruby HTTP client libraries treat connect as a part of
    # request step, with the exception of Net::HTTP which allows opening
    # connection to the server separately to the request, by using
    # Net::HTTP.start.
    #
    # WebMock API was also designed with connect being part of request step,
    # and it only allows stubbing requests, not connections. When
    # Net::HTTP.start is called, WebMock doesn't know yet whether a request
    # is stubbed or not. WebMock by default delays a connection until the
    # request is invoked, so when there is no request, Net::HTTP.start
    # doesn't do anything. This means that WebMock breaks the Net::HTTP
    # behaviour by default!
    #
    # To workaround this issue, WebMock offers :net_http_connect_on_start
    # option, which can be passed to WebMock.allow_net_connect! and
    # WebMock#disable_net_connect! methods, i.e.
    #
    #   WebMock.allow_net_connect!(:net_http_connect_on_start => true)
    #
    # This forces WebMock Net::HTTP adapter to always connect on
    # Net::HTTP.start.
    WebMock.allow_net_connect! net_http_connect_on_start: true
  end

  def disable_network_connections!
    NetworkConnection.disable_network_connections!
  end

  def enable_network_connections!
    NetworkConnection.enable_network_connections!
  end

  # Any test that has to talk to the outside world can use with_network_connection
  # to do so. if a network connection is available the passed in block is called
  # with WebMock's net blocking temporarily disabled.
  #
  # THIS SHOULD BE USED SPARINGLY! if you're testing some external API please mock
  # it up instead.
  def with_network_connection
    begin
      enable_network_connections!
      yield if block_given? && network_connection?
    ensure
      disable_network_connections!
    end
  end


  private def network_connection?
    begin
      !!open("http://www.google.com/")
    rescue
      false
    end
  end

end

RSpec.configure do |config|
  config.before(:each) do
    NetworkConnection.disable_network_connections!
  end
end
