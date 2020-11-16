module Wafalyzer
  class Waf::Stingray < Waf
    register product: "Stingray Application Firewall (Riverbed/Brocade)"

    PATTERN =
      /\AX-Mapping-/i

    builder do
      valid_status :forbidden
      valid_status :internal_server_error
      matches_header "Set-Cookie", PATTERN
    end
  end
end
