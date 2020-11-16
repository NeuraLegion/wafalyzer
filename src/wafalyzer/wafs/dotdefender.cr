module Wafalyzer
  class Waf::DotDefender < Waf
    register product: "dotDefender (Applicure Technologies)"

    PATTERN =
      /dotdefender.blocked.your.request/i

    builder do
      matches_header "X-dotDefender-Denied"
      matches_body PATTERN
    end
  end
end
