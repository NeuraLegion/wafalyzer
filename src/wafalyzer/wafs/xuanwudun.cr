module Wafalyzer
  class Waf::Xuanwudun < Waf
    register product: "Xuanwudun WAF"

    PATTERN =
      /class=.(db)?waf.?(-row.)?>/i

    builder do
      valid_status :forbidden
      matches_body PATTERN
    end
  end
end
