module Wafalyzer
  class Waf::Stackpath < Waf
    register product: "Stackpath WAF (StackPath)"

    PATTERN =
      Regex.union(
        /action.that.triggered.the.service.and.blocked/i,
        /<h2>sorry,.you.have.been.blocked.?<.h2>/i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
