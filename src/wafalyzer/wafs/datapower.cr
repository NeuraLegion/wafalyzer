module Wafalyzer
  class Waf::DataPower < Waf
    register product: "IBM Websphere DataPower Firewall (IBM)"

    PATTERN =
      /\A(ok|fail)/i

    matches_header "X-Backside-Trans", PATTERN
  end
end
