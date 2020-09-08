module Wafalyzer
  class Waf::DodEnterpriseProtection < Waf
    product "DoD Enterprise-Level Protection System (Department of Defense)"

    PATTERN =
      /dod.enterprise.level.protection.system/i

    matches_body PATTERN
  end
end
