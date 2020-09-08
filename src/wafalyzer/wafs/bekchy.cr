module Wafalyzer
  class Waf::Bekchy < Waf
    product "Bekchy (WAF)"

    PATTERN =
      Regex.union(
        /bekchy.(-.)?access.denied/i,
        /(http(s)?:\/\/)(www.)?bekchy.com(\/report)?/i,
      )

    matches_body PATTERN
  end
end
