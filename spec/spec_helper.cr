require "spectator"
require "spectator/should"
require "../src/wafalyzer"

Spectator.configure do |config|
  config.fail_blank
  config.randomize
  config.profile
end
