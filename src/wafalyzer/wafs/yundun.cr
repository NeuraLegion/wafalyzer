module Wafalyzer
  class Waf::Yundun < Waf
    register product: "Yundun Web Application Firewall (Yundun)"

    PATTERN =
      Regex.union(
        /YUNDUN/i,
        /^yd.cookie=/i,
        /http(s)?.\/\/(www\.)?(\w+.)?yundun(.com)?/i,
        /<title>.403.forbidden:.access.is.denied.{0,2}<.{0,2}title>/i,
      )

    matches_header %w(X-Cache Server Set-Cookie), PATTERN

    def matches?(response : HTTP::Client::Response) : Bool
      if response.status.code == 461 && response.body? =~ PATTERN
        Log.debug &.emit("Found body match", {
          pattern: PATTERN.to_s,
          matches: $~.to_a,
        })
        return true
      end
      super
    end
  end
end
