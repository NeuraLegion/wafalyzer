module Wafalyzer
  class Waf::AliYunDun < Waf
    register product: "AliYunDun (WAF)"

    PATTERN =
      Regex.union(
        /error(s)?.aliyun(dun)?.(com|net)/i,
        /http(s)?:\/\/(www.)?aliyun.(com|net)/i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
