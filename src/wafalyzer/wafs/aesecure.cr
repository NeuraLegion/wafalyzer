module Wafalyzer
  class Waf::AeSecure < Waf
    product "aeSecure (WAF)"

    PATTERN =
      /aesecure.denied.png/i

    matches_header "AeSecure-Code"
    matches_body PATTERN
  end
end
