module Wafalyzer
  class Waf::UEWaf < Waf
    product "UEWaf (UCloud)"

    PATTERN =
      Regex.union(
        /http(s)?.\/\/ucloud/i,
        /uewaf(.deny.pages)/i,
      )

    matches_body PATTERN
  end
end
