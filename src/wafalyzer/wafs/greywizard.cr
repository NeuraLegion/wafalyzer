module Wafalyzer
  class Waf::GreyWizard < Waf
    register product: "Grey Wizard Protection"

    PATTERN =
      Regex.union(
        /greywizard(.\d.\d(.\d)?)?/i,
        /grey.wizard.block/i,
        /(http(s)?.\/\/)?(\w+.)?greywizard.com/i,
        /grey.wizard/,
      )

    matches_header %w(GW-Server Server), PATTERN
    matches_body PATTERN
  end
end
