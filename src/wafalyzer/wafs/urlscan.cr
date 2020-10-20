module Wafalyzer
  class Waf::URLScan < Waf
    register product: "URLScan (Microsoft)"

    PATTERN =
      /rejected.by.url.scan/i

    builder do
      matches_header "Location", PATTERN
      matches_body PATTERN
    end
  end
end
