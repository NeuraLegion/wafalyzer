module Wafalyzer
  class Waf::AliYunDun < Waf
    product "AliYunDun (WAF)"

    PATTERN =
      Regex.union(
        /error(s)?.aliyun(dun)?.(com|net)/i,
        /http(s)?:\/\/(www.)?aliyun.(com|net)/i,
      )

    matches_body PATTERN
  end
end
