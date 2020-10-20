module Wafalyzer
  class Waf::GoogleWebServices < Waf
    register product: "Google Web Services (G-Cloud)"

    PATTERN =
      Regex.union(
        /your.client.has.issued.a.malformed.or.illegal.request/i,
        /your.systems.have.detected.unusual.traffic/i,
        /block(ed)?.by.g.cloud.security.policy.+/i,
      )

    builder do
      valid_status :bad_request
      valid_status :too_many_requests
      valid_status :internal_server_error
      matches_body PATTERN
    end
  end
end
