module Wafalyzer
  class Waf::ASM < Waf
    register product: "Application Security Manager (F5 Networks)"

    PATTERN =
      /the.requested.url.was.rejected..please.consult.with.your.administrator./i

    matches_body PATTERN
  end
end
