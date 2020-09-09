module Wafalyzer
  class Waf::Janusec < Waf
    product "Janusec Application Gateway (WAF)"

    PATTERN =
      Regex.union(
        /janusec/i,
        /(http(s)?\W+(www.)?)?janusec.(com|net|org)/i,
      )

    matches_body PATTERN
  end
end
