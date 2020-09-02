module Wafalyzer
  class Waf::AWS < Waf
    product "Amazon Web Services Web Application Firewall (Amazon)"

    PATTERN =
      Regex.union(
        /<RequestId>[0-9a-zA-Z]{16,25}<.RequestId>/i,
        /<Error><Code>AccessDenied<.Code>/i,
      )

    matches_header %w(Server X-Powered-By Set-Cookie), /x.amz.(id.\d+|request.id)/i
    matches_body PATTERN
  end
end
