module Wafalyzer
  class Waf::Teros < Waf
    register product: "Teros Web Application Firewall (Citrix)"

    PATTERN =
      /st8(id|.wa|.wf)?.?(\d+|\w+)?/i

    builder do
      matches_any_header_value PATTERN
    end
  end
end
