module Wafalyzer
  class Waf::RSFirewall < Waf
    product "RSFirewall (Joomla WAF)"

    PATTERN =
      Regex.union(
        /com.rsfirewall.403.forbidden/i,
        /com.rsfirewall.event/i,
        /(\b)?rsfirewall(\b)?/i,
        /rsfirewall/i,
      )

    matches_body PATTERN
  end
end
