module Wafalyzer
  class Waf::ModSecurityOWASP < Waf
    register product: "OWASP ModSecurity Core Rule Set (CRS)"

    PATTERN =
      Regex.union(
        /not.acceptable/i,
        /additionally\S.a.406.not.acceptable/i,
      )

    valid_status :not_acceptable
    matches_body PATTERN
  end
end
