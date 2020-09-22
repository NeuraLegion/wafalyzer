module Wafalyzer
  class Waf::Apache < Waf
    register product: "Apache Generic Protection"

    PATTERN =
      Regex.union(
        /apache/i,
        /.>you.don.t.have.permission.to.access+/i,
        /was.not.found.on.this.server/i,
        /<address>apache\/([\d+{1,2}](.[\d+]{1,2}(.[\d+]{1,3})?)?)?/i,
        /<title>403 Forbidden<\/title>/i,
      )

    valid_status :forbidden
    matches_header "Server", PATTERN
    matches_body PATTERN
  end
end
