module Wafalyzer
  class Waf::AlertLogic < Waf
    register product: "Alert Logic (SIEMless Threat Management)"

    PATTERNS = {
      /.>requested.url.cannot.be.found<./i,
      /proceed.to.homepage/i,
      /back.to.previous.page/i,
      /we(?:'re|.are)?sorry.{1,2}but.the.page.you.are.looking.for.cannot/i,
      /reference.id.?/i,
      /page.has.either.been.removed.{1,2}renamed/i,
    }

    def matches?(response : HTTP::Client::Response) : Bool
      PATTERNS.each do |pattern|
        return false unless response.body? =~ pattern
      end
      Log.debug { "Found body matches" }
      true
    end
  end
end
