module Wafalyzer
  class Waf::Bekchy < Waf
    register product: "Bekchy (WAF)"

    PATTERN =
      Regex.union(
        /bekchy.(-.)?access.denied/i,
        /(http(s)?:\/\/)(www.)?bekchy.com(\/report)?/i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
