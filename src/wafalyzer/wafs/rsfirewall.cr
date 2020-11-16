module Wafalyzer
  class Waf::RSFirewall < Waf
    register product: "RSFirewall (Joomla WAF)"

    PATTERN =
      Regex.union(
        /com.rsfirewall.403.forbidden/i,
        /com.rsfirewall.event/i,
        /(\b)?rsfirewall(\b)?/i,
        /rsfirewall/i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
