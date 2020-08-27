require "http"
require "log"

module Wafalyzer
  Log = ::Log.for(self)

  extend self

  # Returns an array of `Waf`s detected for the given request.
  def detect(url : String | URI, method : String = "GET", headers : HTTP::Headers? = nil, body : HTTP::Client::BodyType? = nil, user_agent : String? = nil) : Array(Waf)
    headers ||= HTTP::Headers.new
    headers["User-Agent"] ||= user_agent || settings.user_agent

    response =
      HTTP::Client.exec(method, url, headers, body)

    Log.debug &.emit "HTTP response received",
      response: response.inspect

    wafs.select do |waf|
      waf.matches?(response)
    rescue ex : IO::Error
      Log.warn(exception: ex) {
        "Possible network level firewall detected (hardware), received an aborted connection"
      }
    end
  end
end

require "./wafalyzer/*"
