module Wafalyzer
  class Waf::Teros < Waf
    product "Teros Web Application Firewall (Citrix)"

    PATTERN =
      /st8(id|.wa|.wf)?.?(\d+|\w+)?/i

    matches_any_header_value PATTERN
  end
end
