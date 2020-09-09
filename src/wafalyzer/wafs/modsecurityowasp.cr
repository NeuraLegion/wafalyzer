module Wafalyzer
  class Waf::ModSecurityOWASP < Waf
    product "OWASP ModSecurity Core Rule Set (CRS)"

    PATTERN =
      Regex.union(
        /not.acceptable/i,
        /additionally\S.a.406.not.acceptable/i,
      )

    matches_status :not_acceptable
    matches_body PATTERN
  end
end
