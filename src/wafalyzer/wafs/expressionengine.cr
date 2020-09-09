module Wafalyzer
  class Waf::ExpressionEngine < Waf
    product "ExpressionEngine (Ellislab WAF)"

    PATTERN =
      Regex.union(
        /.>error.-.expressionengine<./i,
        /.>:.the.uri.you.submitted.has.disallowed.characters.<./i,
        /invalid.get.data/i,
      )

    matches_body PATTERN
  end
end
