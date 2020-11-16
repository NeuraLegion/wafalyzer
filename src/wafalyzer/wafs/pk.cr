module Wafalyzer
  class Waf::PKSecurityModule < Waf
    register product: "pkSecurityModule (IDS)"

    PATTERN =
      Regex.union(
        /.>pkSecurityModule\W..\WSecurity.Alert<./i,
        /.http(s)?.\/\/([w]{3})?.kitnetwork.\w/i,
        /.>A.safety.critical.request.was.discovered.and.blocked.<./i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
