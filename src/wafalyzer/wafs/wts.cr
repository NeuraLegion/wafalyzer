module Wafalyzer
  class Waf::WTS < Waf
    product "WTS-WAF (Web Application Firewall)"

    PATTERN =
      /(<title>)?wts.wa(f)?(\w+(\w+(\w+)?)?)?/i

    matches_body PATTERN
  end
end
