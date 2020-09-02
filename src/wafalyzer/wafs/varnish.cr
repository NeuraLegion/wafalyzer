module Wafalyzer
  class Waf::Varnish < Waf
    product "Varnish/CacheWall WAF"

    PATTERN =
      Regex.union(
        /\bxid. \d+/i,
        /varnish/i,
        /.>.?security.by.cachewall.?<./i,
        /cachewall/i,
        /.>access.is.blocked.according.to.our.site.security.policy.<+/i,
      )

    matches_header %w(X-Varnish X-Cachewall-Action X-Cachewall-Reason)
    matches_header %w(Server Via), PATTERN
    matches_body PATTERN
  end
end
