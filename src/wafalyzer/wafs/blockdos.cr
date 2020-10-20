module Wafalyzer
  class Waf::BlockDos < Waf
    register product: "BlockDos DDoS protection (BlockDos)"

    PATTERN =
      /blockdos\.net/i

    builder do
      matches_header "Server", PATTERN
    end
  end
end
