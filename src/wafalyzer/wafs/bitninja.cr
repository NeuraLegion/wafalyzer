module Wafalyzer
  class Waf::BitNinja < Waf
    product "BitNinja (WAF)"

    PATTERN =
      Regex.union(
        /bitninja/i,
        /security.check.by.bitninja/i,
        /.>visitor.anti(\S)?robot.validation<./i,
      )

    matches_body PATTERN
  end
end
