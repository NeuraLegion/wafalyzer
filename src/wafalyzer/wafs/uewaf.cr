module Wafalyzer
  class Waf::UEWaf < Waf
    register product: "UEWaf (UCloud)"

    PATTERN =
      Regex.union(
        /http(s)?.\/\/ucloud/i,
        /uewaf(.deny.pages)/i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
