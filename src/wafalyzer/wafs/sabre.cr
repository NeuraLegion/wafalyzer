module Wafalyzer
  class Waf::Sabre < Waf
    product "Sabre Firewall (WAF)"

    PATTERN =
      /dxsupport@sabre.com/i

    matches_body PATTERN
  end
end
