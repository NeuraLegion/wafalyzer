module Wafalyzer
  class Waf::Viettel < Waf
    register product: "Viettel WAF (Cloudrity)"

    PATTERN =
      Regex.union(
        # https://github.com/0xInfection/Awesome-WAF
        /<title>access.denied(...)?viettel.waf<\/title>/i,
        /viettel.waf.system/i,
        /(http(s).\/\/)?cloudrity.com(.vn)?/
      )

    builder do
      matches_body PATTERN
    end
  end
end
