module Wafalyzer
  class Waf::EdgeCast < Waf
    product "EdgeCast Web Application Firewall (Verizon)"

    PATTERN =
      /\Aecdf/i

    matches_header "Server", PATTERN
  end
end
