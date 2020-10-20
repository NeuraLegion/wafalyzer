module Wafalyzer
  class Waf::Janusec < Waf
    register product: "Janusec Application Gateway (WAF)"

    PATTERN =
      Regex.union(
        /janusec/i,
        /(http(s)?\W+(www.)?)?janusec.(com|net|org)/i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
