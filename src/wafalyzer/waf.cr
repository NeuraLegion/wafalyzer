require "./waf/*"

module Wafalyzer
  # Array of loaded `Waf` profiles
  class_property wafs = [] of Waf

  abstract class Waf
    Log = ::Log.for(self)

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
      return false unless valid_status?(response)
      return true if matches_headers?(response)
      return true if matches_body?(response)
      false
    end

    protected def valid_status?(response : HTTP::Client::Response) : Bool
      @@status.empty? || @@status.any?(&.==(response.status))
    end

    protected def matches_headers?(response : HTTP::Client::Response) : Bool
      headers = response.headers

      @@headers.each do |name, pattern|
        case name
        when "*any-key*"
          headers.each do |key, _|
            if key =~ pattern
              Log.debug &.emit("Found *any-key* header match", {
                key:     key,
                pattern: pattern.to_s,
                matches: $~.to_a,
              })
              return true
            end
          end
        when "*any-value*"
          headers.each do |key, values|
            if value = values.find(&.=~(pattern))
              Log.debug &.emit("Found *any-value* header match", {
                key:     key,
                value:   value,
                pattern: pattern.to_s,
                matches: $~.to_a,
              })
              return true
            end
          end
        when "*any-key-value*"
          headers.each do |key, values|
            if key =~ pattern
              Log.debug &.emit("Found *any-key-value* header key match", {
                key:     key,
                pattern: pattern.to_s,
                matches: $~.to_a,
              })
              return true
            end
            if value = values.find(&.=~(pattern))
              Log.debug &.emit("Found *any-key-value* header value match", {
                key:     key,
                value:   value,
                pattern: pattern.to_s,
                matches: $~.to_a,
              })
              return true
            end
          end
        else
          if (value = headers[name]?) =~ pattern
            Log.debug &.emit("Found header match", {
              key:     name,
              value:   value,
              pattern: pattern.to_s,
              matches: $~.to_a,
            })
            return true
          end
        end
      end
      false
    end

    protected def matches_body?(response : HTTP::Client::Response) : Bool
      @@body.try do |pattern|
        if response.body? =~ pattern
          Log.debug &.emit("Found body match", {
            pattern: pattern.to_s,
            matches: $~.to_a,
          })
          return true
        end
      end
      false
    end
  end
end

require "./wafs/*"
