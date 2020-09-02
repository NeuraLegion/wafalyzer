module Wafalyzer
  class Waf::Nginx < Waf
    product "Nginx Generic Protection"

    PATTERN =
      Regex.union(
        /nginx/i,
        /you.do(not|n.t)?.have.permission.to.access.this.document/,
      )

    matches_body PATTERN
  end
end
