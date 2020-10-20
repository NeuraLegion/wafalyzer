module Wafalyzer
  class Waf::Barikode < Waf
    register product: "Barikode Web Application Firewall"

    PATTERN =
      Regex.union(
        /.>barikode<./i,
        /<h\d{1}>forbidden.access<.h\d{1}>/i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
