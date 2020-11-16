module Wafalyzer
  class Waf::ShieldSecurity < Waf
    register product: "Shield Security"

    PATTERN =
      Regex.union(
        /blocked.by.the.shield/i,
        /transgression(\(s\))?.against.this/i,
        /url.{1,2}form.or.cookie.data.wasn.t.appropriate/i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
