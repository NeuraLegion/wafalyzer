module Wafalyzer
  class Waf::SonicWALL < Waf
    register product: "SonicWALL Firewall (Dell)"

    PATTERN =
      Regex.union(
        /This.request.is.blocked.by.the.SonicWALL/i,
        /Dell.SonicWALL/i,
        /Web.Site.Blocked.+\bnsa.banner/i,
        /SonicWALL/i,
        /.>policy.this.site.is.blocked<./i,
      )

    matches_header "Server", PATTERN
    matches_body PATTERN
  end
end
