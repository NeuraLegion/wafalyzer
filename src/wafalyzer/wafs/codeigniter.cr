module Wafalyzer
  class Waf::CodeIgniter < Waf
    register product: "XSS/CSRF Filtering Protection (CodeIgniter)"

    PATTERN =
      /the.uri.you.submitted.has.disallowed.characters/i

    valid_status :bad_request
    matches_body PATTERN
  end
end
