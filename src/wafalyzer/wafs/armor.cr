module Wafalyzer
  class Waf::Armor < Waf
    register product: "Armor Protection (Armor Defense)"

    PATTERN =
      Regex.union(
        /\barmor\b/i,
        /blocked.by.website.protection.from.armour/i,
      )

    matches_body PATTERN
  end
end
