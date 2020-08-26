module Wafalyzer
  class Waf::ApacheGeneric < Waf
    product "Apache Generic"

    PATTERN =
      Regex.union(
        /apache/i,
        /.>you.don.t.have.permission.to.access+/i,
        /was.not.found.on.this.server/i,
        /<address>apache\/([\d+{1,2}](.[\d+]{1,2}(.[\d+]{1,3})?)?)?/i,
        /<title>403 Forbidden<\/title>/i,
      )

    matches_status :forbidden
    matches_header "Server", /apache/i
    matches_body PATTERN
  end
end
