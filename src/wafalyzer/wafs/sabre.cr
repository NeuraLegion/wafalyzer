module Wafalyzer
  class Waf::Sabre < Waf
    register product: "Sabre Firewall (WAF)"

    PATTERN =
      /dxsupport@sabre.com/i

    builder do
      matches_body PATTERN
    end
  end
end
