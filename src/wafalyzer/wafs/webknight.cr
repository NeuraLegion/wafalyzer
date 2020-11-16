module Wafalyzer
  class Waf::WebKnight < Waf
    register product: "WebKnight Application Firewall (AQTRONIX)"

    PATTERN =
      /webknight/i

    builder do
      matches_header "Server", PATTERN
    end
  end
end
