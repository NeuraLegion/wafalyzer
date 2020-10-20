module Wafalyzer
  class Waf::Jiasule < Waf
    register product: "Jiasule (WAF)"

    PATTERN =
      Regex.union(
        /^jsl(_)?tracking/i,
        /(__)?jsluid(=)?/i,
        /notice.jiasule/i,
        /(static|www|dynamic).jiasule.(com|net)/i,
      )

    builder do
      matches_header %w(Server Set-Cookie), PATTERN
      matches_body PATTERN
    end
  end
end
