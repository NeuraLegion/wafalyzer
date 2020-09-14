module Wafalyzer
  class Waf::SecureSphere < Waf
    product "Imperva SecureSphere"

    PATTERN =
      Regex.union(
        /<h2>error<.h2>/,
        /<title>error<.title>/i,
        /<b>error<.b>/i,
        /<td.class="(?:errormessage|error)".height="[0-9]{1,3}".width="[0-9]{1,3}">/i,
        /the.incident.id.(?:is|number.is)./i,
        /page.cannot.be.displayed/i,
        /contact.support.for.additional.information/i,
      )

    FALLBACK_PATTERN =
      /the.destination.of.your.request.has.not.been.configured/i

    def matches?(response : HTTP::Client::Response) : Bool
      matches = response.body?.try(&.scan(PATTERN))
      if matches && matches.size >= 2
        Log.debug &.emit("Found body matches", {
          pattern: PATTERN.to_s,
          matches: matches.map(&.to_a),
        })
        return true
      end
      if response.body? =~ FALLBACK_PATTERN
        Log.debug &.emit("Found body match", {
          pattern: FALLBACK_PATTERN.to_s,
          matches: $~.to_a,
        })
        return true
      end
      false
    end
  end
end
