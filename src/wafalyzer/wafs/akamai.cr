module Wafalyzer
  class Waf::Akamai < Waf
    register product: "AkamaiGhost Website Protection (Akamai Global Host)"

    PATTERN =
      Regex.union(
        /.>access.denied<./i,
        /akamaighost/i,
        /ak.bmsc./i,
      )

    builder do
      matches_header %w(Server Set-Cookie), PATTERN
      matches_body PATTERN
    end
  end
end
