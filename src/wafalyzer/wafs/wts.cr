module Wafalyzer
  class Waf::WTS < Waf
    register product: "WTS-WAF (Web Application Firewall)"

    PATTERN =
      /(<title>)?wts.wa(f)?(\w+(\w+(\w+)?)?)?/i

    builder do
      matches_body PATTERN
    end
  end
end
