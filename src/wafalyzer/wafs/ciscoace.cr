module Wafalyzer
  class Waf::CiscoACE < Waf
    register product: "Cisco ACE XML Firewall (Cisco)"

    PATTERN =
      /ace.xml.gateway/i

    matches_header "Server", PATTERN
  end
end
