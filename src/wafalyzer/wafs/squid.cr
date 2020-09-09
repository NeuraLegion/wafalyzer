module Wafalyzer
  class Waf::Squid < Waf
    product "Squid Proxy (IDS)"

    PATTERN =
      Regex.union(
        /access control configuration prevents/i,
        /X.Squid.Error/i,
      )

    matches_header "eventsquid-id"
    matches_any_header /squid/i
    matches_any_header PATTERN
    matches_body PATTERN
  end
end
