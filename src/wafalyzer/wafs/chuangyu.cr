module Wafalyzer
  class Waf::Chuangyu < Waf
    register product: "Chuangyu top government cloud defense platform (WAF)"

    PATTERN =
      /(http(s)?.\/\/(www.)?)?365cyd.(com|net)/i

    builder do
      matches_body PATTERN
    end
  end
end
