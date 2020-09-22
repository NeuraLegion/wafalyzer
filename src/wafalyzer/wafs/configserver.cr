module Wafalyzer
  class Waf::ConfigServer < Waf
    register product: "CSF (ConfigServer Security & Firewall)"

    PATTERN =
      /.>the.firewall.on.this.server.is.blocking.your.connection.<+/i

    matches_body PATTERN
  end
end
