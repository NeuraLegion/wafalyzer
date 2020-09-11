module Wafalyzer
  class Waf::Wallarm < Waf
    product "Wallarm WAF"

    PATTERN =
      /nginix.wallarm/

    matches_header "Server", PATTERN
  end
end
