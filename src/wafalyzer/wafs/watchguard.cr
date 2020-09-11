module Wafalyzer
  class Waf::WatchGuard < Waf
    product "WatchGuard WAF"

    PATTERN =
      Regex.union(
        /(request.denied.by.)?watchguard.firewall/i,
        /watchguard(.technologies(.inc)?)?/i,
      )

    matches_header "Server", /watchguard/i
    matches_body PATTERN
  end
end
