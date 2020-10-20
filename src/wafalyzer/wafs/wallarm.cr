module Wafalyzer
  class Waf::Wallarm < Waf
    register product: "Wallarm WAF"

    PATTERN =
      /nginix.wallarm/

    builder do
      matches_header "Server", PATTERN
    end
  end
end
