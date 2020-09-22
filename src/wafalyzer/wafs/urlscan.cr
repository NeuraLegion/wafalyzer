module Wafalyzer
  class Waf::URLScan < Waf
    register product: "URLScan (Microsoft)"

    PATTERN =
      /rejected.by.url.scan/i

    matches_header "Location", PATTERN
    matches_body PATTERN
  end
end
