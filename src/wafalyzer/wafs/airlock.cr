module Wafalyzer
  class Waf::Airlock < Waf
    register product: "Airlock (Phion/Ergon)"

    matches_header "Set-Cookie", /\Aal[.-]?(sess|lb)=?/i
  end
end
