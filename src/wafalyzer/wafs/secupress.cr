module Wafalyzer
  class Waf::SecuPress < Waf
    register product: "SecuPress (Wordpress WAF)"

    PATTERN =
      Regex.union(
        /<h\d*>secupress<./i,
        /block.id.{1,2}bad.url.contents.<./i,
      )

    matches_body PATTERN
  end
end
