module Wafalyzer
  class Waf::Waf360 < Waf
    register product: "360 Web Application Firewall (360)"

    PATTERN =
      Regex.union(
        /.wzws.waf.cgi/i,
        /wangzhan\.360\.cn/i,
        /qianxin.waf/i,
        /360wzws/,
        /transfer.is.blocked/i,
      )

    matches_header %w(Server X-Powered-By-360wzb), PATTERN
    matches_body PATTERN
  end
end
