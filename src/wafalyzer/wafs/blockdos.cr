module Wafalyzer
  class Waf::BlockDos < Waf
    product "BlockDos DDoS protection (BlockDos)"

    PATTERN =
      /blockdos\.net/i

    matches_header "Server", PATTERN
  end
end
