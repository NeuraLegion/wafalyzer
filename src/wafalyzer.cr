require "http"
require "uri"
require "log"
require "json"

module Wafalyzer
  Log = ::Log.for(self)

  extend self

  private def build_client(uri : URI) : HTTP::Client
    host = uri.host
    host ||
      raise ArgumentError.new "Given URI is missing the host component"

    port = uri.port
    tls = uri.scheme == "https"

    client = HTTP::Client.new(
      host: host,
      port: port,
      tls: tls,
    )

    if timeout = settings.timeout
      client
        .tap(&.dns_timeout = timeout)
        .tap(&.connect_timeout = timeout)
        .tap(&.read_timeout = timeout)
    end
    client
  end

  private def client(uri : URI)
    yield client = build_client(uri)
  ensure
    client.try &.close
  end

  private def exec_request(uri : URI, method : String, headers : HTTP::Headers?, body : HTTP::Client::BodyType?, user_agent : String?) : HTTP::Client::Response
    headers ||= HTTP::Headers.new
    headers["User-Agent"] ||= user_agent || settings.user_agent

    Log.debug &.emit("Sending HTTP request", {
      method:  method,
      url:     uri.to_s,
      headers: headers.to_h,
    })

    client uri, &.exec(method, uri.full_path, headers, body).tap do |response|
      Log.debug &.emit("HTTP response received", {
        status_code: response.status.code,
        headers:     response.headers.to_h,
      })
    end
  rescue ex : IO::Error
    Log.warn(exception: ex) {
      "Possible network level firewall detected (hardware), " \
      "received an aborted connection"
    }
    raise ex
  rescue ex
    Log.warn(exception: ex) {
      "Failed to obtain target metadata"
    }
    raise ex
  end

  # Returns an array of `Waf`s detected for the given request.
  def detect(uri : URI, method : String = "GET", headers : HTTP::Headers? = nil, body : HTTP::Client::BodyType? = nil, user_agent : String? = nil) : Array(Waf)
    response = exec_request(uri, method, headers, body, user_agent)

    wafs.select(&.matches?(response)).tap do |detected|
      Log.debug {
        "Detected wafs: %s" % detected.inspect
      }
    end
  end

  # :ditto:
  def detect(url : String, method : String = "GET", headers : HTTP::Headers? = nil, body : HTTP::Client::BodyType? = nil, user_agent : String? = nil) : Array(Waf)
    uri =
      URI.parse(url)

    detect(uri, method, headers, body, user_agent)
  end

  # Returns `true` if there was any `Waf` detected for the given request.
  def detects?(*args, **kwargs) : Bool
    !detect(*args, **kwargs).empty?
  end
end

require "./wafalyzer/*"
