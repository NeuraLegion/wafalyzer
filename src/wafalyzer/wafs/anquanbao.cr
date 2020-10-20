module Wafalyzer
  class Waf::Anquanbao < Waf
    register product: "Anquanbao Web Application Firewall (Anquanbao)"

    PATTERN =
      /.aqb_cc.error./i

    builder do
      matches_body PATTERN
      matches_any_header_value PATTERN
    end
  end
end
