module Wafalyzer
  class Waf::EdgeCast < Waf
    register product: "EdgeCast Web Application Firewall (Verizon)"

    PATTERN =
      /\Aecdf/i

    builder do
      matches_header "Server", PATTERN
    end
  end
end
