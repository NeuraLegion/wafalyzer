module Wafalyzer
  class Waf::SafeDog < Waf
    register product: "SafeDog WAF (SafeDog)"

    PATTERN =
      Regex.union(
        /(http(s)?)?(:\/\/)?(www|404|bbs|\w+)?.safedog.\w/i,
        /waf(.?\d+.?\d+)/i,
      )

    builder do
      matches_header "X-Powered-By", PATTERN
      matches_body PATTERN
    end
  end
end
