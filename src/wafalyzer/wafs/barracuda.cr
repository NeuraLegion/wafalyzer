module Wafalyzer
  class Waf::Barracuda < Waf
    register product: "Barracuda Web Application Firewall (Barracuda Networks)"

    PATTERN =
      Regex.union(
        /\Abarra.counter.session=?/i,
        /(\A|\b)?barracuda./i,
        /barracuda.networks.{1,2}inc/i,
      )

    matches_header "Set-Cookie", PATTERN
    matches_body PATTERN
  end
end
