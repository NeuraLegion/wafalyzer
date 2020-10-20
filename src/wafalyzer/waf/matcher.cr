module Wafalyzer
  abstract class Waf; end

  module Waf::Matcher
    protected def valid_status?(response : HTTP::Client::Response) : Bool
      valid_status.empty? || valid_status.any?(&.==(response.status))
    end

    protected def matches_headers?(response : HTTP::Client::Response) : Bool
      headers = response.headers
      matches_headers.each do |name, pattern|
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
      matches_body.try do |pattern|
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

    # Returns `true` if given *response* matches defined
    # assertions, `false` otherwise.
    def matches?(response : HTTP::Client::Response) : Bool
      valid_status?(response) &&
        (matches_headers?(response) || matches_body?(response))
    end
  end
end
