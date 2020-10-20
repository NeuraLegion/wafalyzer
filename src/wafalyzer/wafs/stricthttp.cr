module Wafalyzer
  class Waf::StrictHttpFirewall < Waf
    register product: "StrictHttpFirewall (WAF)"

    PATTERN =
      /the.request.was.rejected.because.the.url.contained.a.potentially.malicious.string/i

    builder do
      valid_status :internal_server_error
      matches_body PATTERN
    end
  end
end
