module Wafalyzer
  class Waf::URLScan < Waf
    product "URLScan (Microsoft)"

    PATTERN =
      /rejected.by.url.scan/i

    matches_header "Location", PATTERN
    matches_body PATTERN
  end
end
