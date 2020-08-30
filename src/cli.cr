require "option_parser"
require "climate"
require "./wafalyzer"

protected def fail(message : String? = nil)
  if message = message.presence
    message = "!Error¡: #{message}"
  end
  abort(message.try(&.climatize))
end

Climate.configure do |settings|
  settings.use_defaults!
end

Colorize.on_tty_only!

method = "GET"
body = nil
json = false
timeout = nil

use_random_user_agent = false
user_agent = nil

OptionParser.parse do |parser|
  parser.banner = "Usage: {#{PROGRAM_NAME}} <url> [arguments]"

  parser.on "-m VALUE", "--method=VALUE", "Uses supplied method type when issuing request" do |value|
    method = value.upcase
  end
  parser.on "-b VALUE", "--body=VALUE", "Uses supplied body when issuing request" do |value|
    body = value
  end
  parser.on "-j", "--json", "Exports results as JSON string" do
    json = true
  end
  parser.on "-t VALUE", "--timeout=VALUE", "Sets the connection timeout to the given value (in seconds)" do |value|
    timeout = value.to_i.seconds
  end
  parser.on "-r", "--random-user-agent", "Uses a random user agent string for the issued HTTP requests" do
    use_random_user_agent = true
  end
  parser.on "-u VALUE", "--user-agent=VALUE", "Uses supplied user agent string" do |value|
    user_agent = value
  end

  parser.on "--wafs", "Outputs a list of possible firewalls that can be detected" do
    puts Wafalyzer.wafs.join('\n')
    exit
  end
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
  fail "No <url> given!"

Wafalyzer.configure do |settings|
  settings.timeout = timeout
  settings.use_random_user_agent = use_random_user_agent
end

wafs = Wafalyzer.detect(
  url: url,
  method: method,
  body: body,
  user_agent: user_agent,
)

if json
  puts wafs.to_json
  exit
end

case wafs.size
when 0
  puts "No WAF detected"
when 1
  puts "Detected WAF: %s" % \
    wafs.first.colorize(:green)
else
  puts "Detected more than one (!) WAF: %s" % \
    wafs.join(", ", &.colorize(:green))
end
