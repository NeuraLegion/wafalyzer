module Wafalyzer
  class Waf::AWSLB < Waf
    register product: "Amazon Web Services Web Application Firewall / ALB (Amazon)"

    builder do
      matches_header %w(Server), /awselb/i
      valid_status :forbidden
    end
  end
end
