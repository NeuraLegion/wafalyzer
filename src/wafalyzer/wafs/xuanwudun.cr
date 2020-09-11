module Wafalyzer
  class Waf::Xuanwudun < Waf
    product "Xuanwudun WAF"

    PATTERN =
      /class=.(db)?waf.?(-row.)?>/i

    valid_status :forbidden
    matches_body PATTERN
  end
end
