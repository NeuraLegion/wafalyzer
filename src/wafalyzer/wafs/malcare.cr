module Wafalyzer
  class Waf::MalCare < Waf
    register product: "MalCare (MalCare Security WAF)"

    PATTERN =
      Regex.union(
        /malcare/i,
        /.>login.protection<.+.><.+>powered.by<.+.>(<.+.>)?(.?malcare.-.pro|blogvault)?/i,
        /.>firewall<.+.><.+>powered.by<.+.>(<.+.>)?(.?malcare.-.pro|blogvault)?/i,
      )

    builder do
      matches_body PATTERN
    end
  end
end
