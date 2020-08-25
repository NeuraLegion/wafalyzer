require "option_parser"
require "./wafalyzer"

OptionParser.parse do |parser|
  parser.banner = "Usage: wafalyzer [arguments]"

  parser.on "-v", "--version", "Shows version" do
    puts Wafalyzer::VERSION
    exit
  end
  parser.on "-h", "--help", "Shows help" do
    puts parser
    exit
  end
end
