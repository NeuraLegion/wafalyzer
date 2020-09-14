module Wafalyzer
  class Waf::ASPNet < Waf
    product "ASP.NET Generic Website Protection (Microsoft)"

    PATTERN =
      Regex.union(
        /this.generic.403.error.means.that.the.authenticated/i,
        /request.could.not.be.understood/i,
        /<.+>a.potentially.dangerous.request(?:.querystring)?.+/i,
        /runtime.error/i,
        /.>a.potentially.dangerous.request.path.value.was.detected.from.the.client+/i,
        /asp.net.sessionid/i,
        /errordocument.to.handle.the.request/i,
        /an.application.error.occurred.on.the.server/i,
        /error.log.record.number/i,
        /error.page.might.contain.sensitive.information/i,
        /<.+>server.error.in.'\/'.application.+/i,
        /\basp.net\b/i,
      )

    def matches?(response : HTTP::Client::Response) : Bool
      headers = response.headers
      detected = 0

      if matches = response.body?.try(&.scan(PATTERN))
        detected += matches.size
      end
      if matches = headers["Set-Cookie"]?.try(&.scan(PATTERN))
        detected += matches.size
      end
      detected += 1 if headers["X-ASPNET-Version"]?.presence
      detected += 1 if headers["ASP-ID"]?.presence
      detected += 1 if headers["X-Powered-By"]?.presence == "ASP.NET"

      if detected >= 2
        Log.debug { "Found matches" }
        return true
      end
      false
    end
  end
end
