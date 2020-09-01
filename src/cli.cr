require "option_parser"
require "climate"
require "./wafalyzer"

protected def fail(message : String? = nil)
  if message = message.presence
    message = "!Error¡: #{message}"
  end
  abort(message.try(&.climatize))
end

Log
  .setup_from_env

Colorize
  .on_tty_only!

Climate.settings
  .use_defaults!

method = "GET"
headers = HTTP::Headers.new
body = nil
timeout = nil
fallback_requests_count = 3
json = false
use_random_user_agent = false
user_agent = nil

OptionParser.parse do |parser|
  parser.banner = "Usage: {#{PROGRAM_NAME}} [arguments] <url>"

  parser.on "-m VALUE", "--method=VALUE", "Uses supplied method type when issuing request" do |value|
    method = value.upcase
  end

  parser.on "-b VALUE", "--body=VALUE", "Uses supplied body when issuing request" do |value|
    body = value
  end

  parser.on "-h VALUE", "--header=VALUE", "Uses supplied header when issuing request" do |value|
    header = value.split('=', 2)
    unless header.size == 2
      fail %(Value given for the [--header] argument should have format "name=value")
    end
    key, value = header
    headers[key] = value
  end

  parser.on "-t VALUE", "--timeout=VALUE", "Sets the connection timeout to the given value (in seconds)" do |value|
    timeout = value.to_i.seconds
  end

  parser.on "-i VALUE", "--fallback-requests-count=VALUE", "Sets the number of additional iterations (after 1st failed request)" do |value|
    fallback_requests_count = value.to_i
  end

  parser.on "-j", "--json", "Exports results as JSON string" do
    json = true
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

  parser.on "--help", "Shows help" do
    puts parser.to_s.climatize
    exit
  end
end

url = ARGV[0]?
url ||
  fail "No <url> given!"

Wafalyzer.configure do |settings|
  settings.timeout = timeout
  settings.fallback_requests_count = fallback_requests_count
  settings.use_random_user_agent = use_random_user_agent
end

wafs = Wafalyzer.detect(
  url: url,
  method: method,
  headers: headers,
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
