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
      return false unless matches_status?(response)
      return true if matches_headers?(response)
      return true if matches_body?(response)
      false
    end

    protected def matches_status?(response : HTTP::Client::Response) : Bool
      @@status.try do |status|
        return response.status == status
      end
      true
    end

    protected def matches_headers?(response : HTTP::Client::Response) : Bool
      headers = response.headers

      @@headers.each do |name, pattern|
        case name
        when "*any-key*"
          headers.each do |key, _|
            return true if key.matches?(pattern)
          end
        when "*any-value*"
          headers.each do |_, values|
            return true if values.any?(&.matches?(pattern))
          end
        when "*any-key-value*"
          headers.each do |key, values|
            return true if key.matches?(pattern)
            return true if values.any?(&.matches?(pattern))
          end
        else
          return true if headers[name]? =~ pattern
        end
      end
      false
    end

    protected def matches_body?(response : HTTP::Client::Response) : Bool
      @@body.try do |body|
        return true if response.body? =~ body
      end
      false
    end
  end
end

require "./wafs/*"
