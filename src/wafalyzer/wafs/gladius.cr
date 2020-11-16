module Wafalyzer
  class Waf::Gladius < Waf
    register product: "Gladius network WAF (Gladius)"

    builder do
      matches_header "gladius_blockchain_driven_cyber_protection_network_session"
    end
  end
end
