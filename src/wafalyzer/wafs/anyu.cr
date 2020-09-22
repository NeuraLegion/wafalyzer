module Wafalyzer
  class Waf::Anyu < Waf
    register product: "AnYu Web Application Firewall (Anyu Technologies)"

    PATTERN =
      Regex.union(
        /sorry.{1,2}your.access.has.been.intercept(ed)?.by.anyu/i,
        /anyu/i,
        /anyu-?.the.green.channel/i,
      )

    matches_body PATTERN

    def matches?(response : HTTP::Client::Response) : Bool
      event_id = response.headers["WZWS-RAY"]?.presence
      if event_id && response.body? =~ /#{Regex.escape(event_id)}/i
        Log.debug &.emit(%(Found "WZWS-RAY" header body match), {
          value: event_id,
        })
        return true
      end
      super
    end
  end
end
