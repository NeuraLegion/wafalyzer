module Wafalyzer
  class Waf::Instart < Waf
    register product: "Instart Logic (Palo Alto)"

    PATTERN =
      /instartrequestid/i

    matches_header %w(X-Instart-Request-ID X-Instart-CacheKeyMod)
    matches_body PATTERN
  end
end
