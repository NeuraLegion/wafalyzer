module Wafalyzer
  class Waf::BinarySEC < Waf
    register product: "BinarySEC Web Application Firewall (BinarySEC)"

    PATTERN =
      Regex.union(
        /x.binarysec.(via|nocache)/i,
        /binarysec/i,
        /\bbinarysec\b/i,
      )

    matches_any_header PATTERN
  end
end
