module Wafalyzer
  class Waf::PerimeterX < Waf
    register product: "Anti Bot Protection (PerimeterX)"

    PATTERN =
      Regex.union(
        /access.to.this.page.has.been.denied.because.we.believe.you.are.using.automation.tool/i,
        /http(s)?:\/\/(www.)?perimeterx.\w+.whywasiblocked/i,
        /perimeterx/i,
        /(..)?client.perimeterx.*\/[a-zA-Z]{8,15}\/*.*.js/i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
