module Wafalyzer
  class Waf::AeSecure < Waf
    register product: "aeSecure (WAF)"

    PATTERN =
      /aesecure.denied.png/i

    matches_header "AeSecure-Code"
    matches_body PATTERN
  end
end
