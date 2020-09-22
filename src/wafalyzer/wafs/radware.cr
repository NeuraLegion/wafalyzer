module Wafalyzer
  class Waf::Radware < Waf
    register product: "Radware (AppWall WAF)"

    PATTERN =
      Regex.union(
        /.\bcloudwebsec.radware.com\b./i,
        /.>unauthorized.activity.has.been.detected<./i,
        /with.the.following.case.number.in.its.subject:.\d+./i,
      )

    matches_body PATTERN
  end
end
