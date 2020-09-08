module Wafalyzer
  class Waf::DenyAll < Waf
    product "Deny All Web Application Firewall (DenyAll)"

    matches_header "Set-Cookie", /\Asessioncookie=/i
    matches_body /\Acondition.intercepted/i
  end
end
