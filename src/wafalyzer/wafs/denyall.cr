module Wafalyzer
  class Waf::DenyAll < Waf
    register product: "Deny All Web Application Firewall (DenyAll)"

    builder do
      matches_header "Set-Cookie", /\Asessioncookie=/i
      matches_body /\Acondition.intercepted/i
    end
  end
end
