module Wafalyzer
  class Waf::NexusGuard < Waf
    register product: "NexusGuard Security (WAF)"

    PATTERN =
      Regex.union(
        /nexus.?guard/i,
        /((http(s)?:\/\/)?speresources.)?nexusguard.com.wafpage/i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
