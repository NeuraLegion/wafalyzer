module Wafalyzer
  class Waf::Sucuri < Waf
    register product: "Sucuri Firewall (Sucuri Cloudproxy)"

    PATTERN =
      Regex.union(
        /access.denied.-.sucuri.website.firewall/i,
        /sucuri.webSite.firewall.-.cloudProxy.-.access.denied/i,
        /questions\?.+cloudproxy@sucuri\.net/i,
        /http(s)?.\/\/(cdn|supportx.)?sucuri(.net|com)?/i,
      )

    matches_header "X-Sucuri-Block"
    matches_header "Server", "Sucuri/Cloudproxy"
    matches_body PATTERN
  end
end
