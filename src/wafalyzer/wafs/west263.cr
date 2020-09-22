module Wafalyzer
  class Waf::West236 < Waf
    register product: "West236 Firewall"

    PATTERN =
      /wt\d*cdn/i

    matches_header "X-Cache", PATTERN
  end
end
