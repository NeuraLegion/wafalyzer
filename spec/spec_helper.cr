require "spectator"
require "spectator/should"
require "../src/wafalyzer"
require "./support"
require "./wafalyzer/*"

Spectator.configure do |config|
  config.fail_blank
  config.randomize
  config.profile
end

module Wafalyzer
  class Waf::ToughWaf < Waf
    product "Tough XTreme Super Pro Plus Hardcore 3000 WAF Solution"

    PATTERN =
      Regex.union(
        /!you are very naughty visitor!/i,
        /__tough_id/i,
      )

    matches_header %w(Server Set-Cookie), PATTERN
    matches_body PATTERN
  end

  class Waf::SuperToughWaf < Waf
    product "***"

    matches_status :forbidden
    matches_header %w(Server Cookies Set-Cookie), /__s0m00cht0ugh/
  end
end
