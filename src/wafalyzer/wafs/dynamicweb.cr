module Wafalyzer
  class Waf::DynamicWeb < Waf
    register product: "DynamicWeb Injection Check (DynamicWeb)"

    PATTERN =
      /dw.inj.check/i

    valid_status :forbidden
    matches_header "X-403-Status-By", PATTERN
  end
end
