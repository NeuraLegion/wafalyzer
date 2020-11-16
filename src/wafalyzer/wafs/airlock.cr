module Wafalyzer
  class Waf::Airlock < Waf
    register product: "Airlock (Phion/Ergon)"

    builder do
      matches_header "Set-Cookie", /\Aal[.-]?(sess|lb)=?/i
    end
  end
end
