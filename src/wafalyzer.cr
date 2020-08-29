require "http"
require "log"

module Wafalyzer
  Log = ::Log.for(self)

  extend self

  # Returns an array of `Waf`s detected for the given request.
  def detect(url : String | URI, method : String = "GET", headers : HTTP::Headers? = nil, body : HTTP::Client::BodyType? = nil, user_agent : String? = nil) : Array(Waf)
    headers ||= HTTP::Headers.new
    headers["User-Agent"] ||= user_agent || settings.user_agent

    Log.debug {
      "Sending HTTP %s request to url '%s' with headers: %s" % {method, url, headers.to_h}
    }

    response =
      HTTP::Client.exec(method, url, headers, body)

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

  # Returns `true` if there was any `Waf` detected for the given request.
  def detects?(*args, **kwargs) : Bool
    !detect(*args, **kwargs).empty?
  end
end

require "./wafalyzer/*"
