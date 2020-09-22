module Wafalyzer
  class Waf::Infosafe < Waf
    register product: "INFOSAFE by http://7i24.com"

    PATTERN =
      Regex.union(
        /infosafe/i,
        /by.(http(s)?(.\/\/)?)?7i24.(com|net)/i,
        /infosafe.\d.\d/i,
        /var.infosafekey=/i,
      )

    matches_header "Server", PATTERN
    matches_body PATTERN
  end
end
