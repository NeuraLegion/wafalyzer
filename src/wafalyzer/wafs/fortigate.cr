module Wafalyzer
  class Waf::FortiGate < Waf
    product "FortiWeb Web Application Firewall (Fortinet)"

    PATTERN =
      Regex.union(
        /.>powered.by.fortinet<./i,
        /.>fortigate.ips.sensor<./i,
        /fortigate/i,
        /.fgd_icon/i,
        /\AFORTIWAFSID=/i,
        /application.blocked./i,
        /.fortiGate.application.control/i,
        /(http(s)?)?:\/\/\w+.fortinet(.\w+:)?/i,
        /fortigate.hostname/i,
        /the.page.cannot.be.displayed..please.contact.[^@]+@[^@]+\.[^@]+.for.additional.information/i,
      )

    matches_header "Set-Cookie", PATTERN
    matches_body PATTERN
  end
end
