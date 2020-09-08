module Wafalyzer
  class Waf::Chuangyu < Waf
    product "Chuangyu top government cloud defense platform (WAF)"

    PATTERN =
      /(http(s)?.\/\/(www.)?)?365cyd.(com|net)/i

    matches_body PATTERN
  end
end
