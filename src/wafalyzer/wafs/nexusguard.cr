module Wafalyzer
  class Waf::NexusGuard < Waf
    product "NexusGuard Security (WAF)"

    PATTERN =
      Regex.union(
        /nexus.?guard/i,
        /((http(s)?:\/\/)?speresources.)?nexusguard.com.wafpage/i,
      )

    matches_body PATTERN
  end
end
