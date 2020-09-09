module Wafalyzer
  class Waf::Powerful < Waf
    product "Powerful Firewall (MyBB plugin)"

    PATTERN =
      Regex.union(
        /Powerful Firewall/i,
        /http(s)?...tiny.cc.powerful.firewall/i,
      )

    matches_status :forbidden
    matches_body PATTERN
  end
end
