module Wafalyzer
  class Waf::Wordfence < Waf
    register product: "Wordfence (Feedjit)"

    PATTERN =
      Regex.union(
        /generated.by.wordfence/i,
        /your.access.to.this.site.has.been.limited/i,
        /.>wordfence<./i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
