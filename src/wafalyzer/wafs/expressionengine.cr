module Wafalyzer
  class Waf::ExpressionEngine < Waf
    register product: "ExpressionEngine (Ellislab WAF)"

    PATTERN =
      Regex.union(
        /.>error.-.expressionengine<./i,
        /.>:.the.uri.you.submitted.has.disallowed.characters.<./i,
        /invalid.get.data/i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
