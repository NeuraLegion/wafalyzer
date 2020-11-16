module Wafalyzer
  class Waf::BitNinja < Waf
    register product: "BitNinja (WAF)"

    PATTERN =
      Regex.union(
        /bitninja/i,
        /security.check.by.bitninja/i,
        /.>visitor.anti(\S)?robot.validation<./i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
