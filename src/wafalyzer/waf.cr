require "./waf/*"

module Wafalyzer
  # Array of loaded `Waf` profiles
  class_property wafs = [] of Waf

  abstract class Waf
    macro inherited
      {% unless @type.abstract? %}
        ::Wafalyzer.wafs << new
      {% end %}
    end

    def to_s(io : IO) : Nil
      io << product?
    end

    def to_json(json : JSON::Builder)
      {product: product?}.to_json(json)
    end

    # Returns `true` if given *response* matches defined
    # assertions, `false` otherwise.
    def matches?(response : HTTP::Client::Response) : Bool
      headers = response.headers

      @@status.try do |status|
        return false unless response.status == status
      end
      @@headers.each do |name, pattern|
        return true if headers[name]? =~ pattern
      end
      @@body.try do |body|
        return true if response.body? =~ body
      end
      false
    end
  end
end

require "./wafs/*"
