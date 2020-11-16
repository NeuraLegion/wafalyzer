module Wafalyzer
  class Waf::DiDiYun < Waf
    register product: "DiDiYun WAF (DiDi)"

    PATTERN =
      Regex.union(
        /(http(s)?:\/\/)(sec-waf.|www.)?didi(static|yun)?.com(\/static\/cloudwafstatic)?/i,
        /didiyun/i,
      )

    builder do
      matches_header "Server", "DiDi-SLB"
      matches_body PATTERN
    end
  end
end
