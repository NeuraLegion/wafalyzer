require "option_parser"
require "climate"
require "./wafalyzer"

Climate.configure do |settings|
  settings.use_defaults!
end

Colorize.on_tty_only!

OptionParser.parse do |parser|
  parser.banner = "Usage: {#{PROGRAM_NAME}} <url> [arguments]"

  parser.on "-v", "--version", "Shows version" do
    puts Wafalyzer::VERSION
    exit
  end
  parser.on "-h", "--help", "Shows help" do
    puts parser.to_s.climatize
    exit
  end
end

url = ARGV[0]?
url ||
  abort "No <url> given!".climatize

wafs = Wafalyzer.detect(url)

case wafs.size
when 0
  puts "No WAF detected"
when 1
  puts "Detected WAF: %s" % \
    wafs.first.product.colorize(:green)
else
  puts "Detected more than one (!) WAF: %s" % \
    wafs.join(", ", &.product.colorize(:green))
end
