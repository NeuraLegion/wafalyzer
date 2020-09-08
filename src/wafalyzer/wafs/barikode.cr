module Wafalyzer
  class Waf::Barikode < Waf
    product "Barikode Web Application Firewall"

    PATTERN =
      Regex.union(
        /.>barikode<./i,
        /<h\d{1}>forbidden.access<.h\d{1}>/i,
      )

    matches_body PATTERN
  end
end
