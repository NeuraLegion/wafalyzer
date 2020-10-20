module Wafalyzer
  class Waf::Zscaler < Waf
    register product: "Zscaler Cloud Firewall (WAF)"

    PATTERN =
      Regex.union(
        /zscaler/i,
        /zscaler(.\d+(.\d+)?)?/i,
      )

    builder do
      matches_header "Server", PATTERN
      matches_body PATTERN
    end
  end
end
