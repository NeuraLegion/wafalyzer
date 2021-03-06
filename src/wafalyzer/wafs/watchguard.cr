module Wafalyzer
  class Waf::WatchGuard < Waf
    register product: "WatchGuard WAF"

    PATTERN =
      Regex.union(
        /(request.denied.by.)?watchguard.firewall/i,
        /watchguard(.technologies(.inc)?)?/i,
      )

    builder do
      matches_header "Server", /watchguard/i
      matches_body PATTERN
    end
  end
end
