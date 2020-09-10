module Wafalyzer
  class Waf::Anquanbao < Waf
    product "Anquanbao Web Application Firewall (Anquanbao)"

    PATTERN =
      /.aqb_cc.error./i

    matches_body PATTERN
    matches_any_header_value PATTERN
  end
end
