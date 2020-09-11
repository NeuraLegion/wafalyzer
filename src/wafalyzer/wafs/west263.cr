module Wafalyzer
  class Waf::West236 < Waf
    product "West236 Firewall"

    PATTERN =
      /wt\d*cdn/i

    matches_header "X-Cache", PATTERN
  end
end
