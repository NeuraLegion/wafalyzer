module Wafalyzer
  class Waf::Comodo < Waf
    register product: "Comodo Web Application Firewall (Comodo)"

    PATTERN =
      /protected.by.comodo.waf/i

    matches_header "Server", PATTERN
  end
end
