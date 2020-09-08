module Wafalyzer
  class Waf::BigIP < Waf
    product "BIG-IP (F5 Networks)"

    PATTERN =
      Regex.union(
        /\ATS\w{4,}=/i,
        /bigipserver(.i)?|bigipserverinternal/i,
        /\AF5\Z/i,
        /^TS[a-zA-Z0-9]{3,8}=/i,
        /BigIP|BIG-IP|BIGIP/,
        /bigipserver/i,
      )

    matches_header %w(Server Set-Cookie Cookie), PATTERN
  end
end
