module Wafalyzer
  class Waf::DosArrest < Waf
    product "DOSarrest (DOSarrest Internet Security)"

    PATTERN =
      Regex.union(
        /dosarrest/i,
        /x.dis.request.id/i,
      )

    matches_any_header PATTERN
  end
end
