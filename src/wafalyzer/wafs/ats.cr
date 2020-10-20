module Wafalyzer
  class Waf::ATS < Waf
    register product: "Apache Traffic Server (ATS web proxy)"

    PATTERN =
      Regex.union(
        /(\()?apachetrafficserver((\/)?\d+(.\d+(.\d+)?)?)/i,
        /ats((\/)?(\d+(.\d+(.\d+)?)?))?/i,
        /ats/i,
      )

    builder do
      matches_header %w(Via Server), PATTERN
    end
  end
end
