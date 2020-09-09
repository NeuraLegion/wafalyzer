module Wafalyzer
  class Waf::CloudFlare < Waf
    product "CloudFlare Web Application Firewall (CloudFlare)"

    PATTERN =
      Regex.union(
        /cloudflare.ray.id.|var.cloudflare./i,
        /cloudflare.nginx/i,
        /..cfduid=([a-z0-9]{43})?/i,
        /cf[-|_]ray(..)?([0-9a-f]{16})?[-|_]?(dfw|iad)?/i,
        /.>attention.required!.\|.cloudflare<.+/i,
        /http(s)?.\/\/report.(uri.)?cloudflare.com(\/cdn.cgi(.beacon\/expect.ct)?)?/i,
        /ray.id/i,
      )

    matches_header %w(CF-Cache-Status CF-Ray CF-Request-ID)
    matches_header %w(Set-Cookie), /__cfduid/
    matches_header %w(Expect-CT), /cloudflare/
    matches_header %w(Server Cookie Set-Cookie Expect-CT), PATTERN
    matches_body PATTERN
  end
end
