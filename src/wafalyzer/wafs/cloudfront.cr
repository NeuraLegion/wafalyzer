module Wafalyzer
  class Waf::CloudFront < Waf
    register product: "CloudFront Firewall (Amazon)"

    PATTERN =
      Regex.union(
        /[a-zA-Z0-9]{,60}.cloudfront.net/i,
        /cloudfront/i,
        /x.amz.cf.id|nguardx/i,
      )

    matches_any_header_value PATTERN
  end
end
