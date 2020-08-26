module Wafalyzer
  class Waf::Akamai < Waf
    product "AkamaiGhost Website Protection (Akamai Global Host)"

    PATTERN =
      Regex.union(
        /.>access.denied<./i,
        /akamaighost/i,
        /ak.bmsc./i,
      )

    matches_header %w(Server Set-Cookie), PATTERN
    matches_body PATTERN
  end
end
