module Wafalyzer
  class Waf::DosArrest < Waf
    register product: "DOSarrest (DOSarrest Internet Security)"

    PATTERN =
      Regex.union(
        /dosarrest/i,
        /x.dis.request.id/i,
      )

    builder do
      matches_any_header PATTERN
    end
  end
end
