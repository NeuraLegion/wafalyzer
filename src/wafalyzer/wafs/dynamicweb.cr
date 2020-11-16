module Wafalyzer
  class Waf::DynamicWeb < Waf
    register product: "DynamicWeb Injection Check (DynamicWeb)"

    PATTERN =
      /dw.inj.check/i

    builder do
      valid_status :forbidden
      matches_header "X-403-Status-By", PATTERN
    end
  end
end
