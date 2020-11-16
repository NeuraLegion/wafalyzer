module Wafalyzer
  class Waf::LiteSpeed < Waf
    register product: "LiteSpeed Generic Protection"

    PATTERN =
      Regex.union(
        /litespeed.web.server/i
      )

    builder do
      matches_body PATTERN
    end
  end
end
