module Wafalyzer
  class Waf::ModSecurity < Waf
    product "Open Source Web Application Firewall (ModSecurity)"

    PATTERN =
      Regex.union(
        /ModSecurity|NYOB/i,
        /mod_security/i,
        /this.error.was.generated.by.mod.security/i,
        /web.server at/i,
        /page.you.are.(accessing|trying)?.(to|is)?.(access)?.(is|to)?.(restricted)?/i,
        /blocked.by.mod.security/i,
      )

    matches_body PATTERN
  end
end
