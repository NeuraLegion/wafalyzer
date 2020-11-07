# wafalyzer ![Build Status](https://github.com/NeuraLegion/wafalyzer/workflows/CI/badge.svg) [![Releases](https://img.shields.io/github/release/NeuraLegion/wafalyzer.svg)](https://github.com/NeuraLegion/wafalyzer/releases) [![License](https://img.shields.io/github/license/NeuraLegion/wafalyzer.svg)](https://github.com/NeuraLegion/wafalyzer/blob/master/LICENSE)

Wafalyzer is a firewall detection utility, which attempts to determine what WAF (if any) is in the front of a web application. It does that by means of passive analysis of the HTTP response metadata (status, headers, body) and if that fails, issuing additional requests with popular malicious payloads in order to (eventually) trigger WAF's response.

## Installation

### Shard

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     wafalyzer:
       github: NeuraLegion/wafalyzer
   ```

2. Run `shards install`

### CLI

1. Run `shards build`
2. 🐗

## Usage

Wafalyzer can be used as both - shard and/or standalone CLI utility.

### Shard

```crystal
require "wafalyzer"

# See `Wafalyzer::Settings` for all available options.
Wafalyzer.configure do |settings|
  settings.use_random_user_agent = true
end

# See `Wafalyzer.detect` for all available options.
Wafalyzer.detect(
  url: "https://www.apple.com",
  method: "POST",
)
# => [#<Wafalyzer::Waf::Akamai>]
```

### CLI

```console
$ ./bin/wafalyzer -m POST -r https://www.apple.com
```

All of the flags can be listed by, passing `--help`.

```console
$ ./bin/wafalyzer --help
```

You can use `LOG_LEVEL` env variable to set the desired
logs severity at runtime.

```console
$ LOG_LEVEL=debug ./bin/wafalyzer https://github.com
```

## Development

Run specs with:

```
crystal spec
```

## Contributing

1. Fork it (<https://github.com/NeuraLegion/wafalyzer/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Sijawusz Pur Rahnama](https://github.com/Sija) - creator and maintainer
