module Wafalyzer
  class Waf::PaloAlto < Waf
    register product: "Palo Alto Firewall (Palo Alto Networks)"

    PATTERN =
      Regex.union(
        /has.been.blocked.in.accordance.with.company.policy/,
        /.>Virus.Spyware.Download.Blocked<./,
      )

    matches_body PATTERN
  end
end
