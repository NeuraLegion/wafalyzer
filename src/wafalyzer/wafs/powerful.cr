module Wafalyzer
  class Waf::Powerful < Waf
    register product: "Powerful Firewall (MyBB plugin)"

    PATTERN =
      Regex.union(
        /Powerful Firewall/i,
        /http(s)?...tiny.cc.powerful.firewall/i,
      )

    builder do
      valid_status :forbidden
      matches_body PATTERN
    end
  end
end
