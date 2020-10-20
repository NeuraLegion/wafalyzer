module Wafalyzer
  class Waf::Yunsuo < Waf
    register product: "Yunsuo Web Application Firewall (Yunsuo)"

    PATTERN =
      Regex.union(
        /<img.class=.yunsuologo./i,
        /yunsuo.session/i,
      )

    builder do
      matches_body PATTERN
      matches_any_header_value PATTERN
    end
  end
end
