module Wafalyzer
  class Waf::WebSEAL < Waf
    register product: "IBM Security Access Manager (WebSEAL)"

    PATTERN =
      Regex.union(
        /webseal.error.message.template/i,
        /webseal.server.received.an.invalid.http.request/i,
      )

    matches_header "Server", "WebSEAL"
    matches_body PATTERN
  end
end
