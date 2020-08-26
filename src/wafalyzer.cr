require "http"
require "log"

module Wafalyzer
  Log = ::Log.for(self)

  extend self

  # Returns an array of `Waf`s detected for the given request.
  def detect(url : String | URI, method : String = "GET", headers : HTTP::Headers? = nil, body : HTTP::Client::BodyType? = nil) : Array(Waf)
    response =
      HTTP::Client.exec(method, url, headers, body)

    Log.debug &.emit "HTTP response received",
      response: response.inspect

    wafs.select(&.matches?(response))
  end
end

require "./wafalyzer/*"
