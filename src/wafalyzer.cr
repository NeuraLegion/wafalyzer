require "http"
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

  # Returns an array of `Waf`s detected for the given request.
  def detect(uri : URI, method : String = "GET", headers : HTTP::Headers? = nil, body : HTTP::Client::BodyType? = nil, user_agent : String? = nil) : Array(Waf)
    headers ||= HTTP::Headers.new
    headers["User-Agent"] ||= user_agent || settings.user_agent

    Log.debug {
      "Sending HTTP %s request to url '%s' with headers: %s" % {method, uri, headers.to_h}
    }

    response =
      build_client(uri).exec(method, uri.full_path, headers, body)

    Log.debug {
      "HTTP response received: %s" % response.inspect
    }

    detected = wafs.select do |waf|
      waf.matches?(response)
    rescue ex : IO::Error
      Log.warn(exception: ex) {
        "(%s): Possible network level firewall detected (hardware), " \
        "received an aborted connection" % waf.inspect
      }
    end
    Log.debug {
      "Detected wafs: %s" % detected.inspect
    }
    detected
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
