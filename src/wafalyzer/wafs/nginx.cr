module Wafalyzer
  class Waf::Nginx < Waf
    register product: "Nginx Generic Protection"

    PATTERN = /you.do(not|n.t)?.have.permission.to.access.this.document/

    builder do
      matches_body PATTERN
    end
  end
end
