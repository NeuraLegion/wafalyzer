module Wafalyzer
  abstract class Waf
    # Full name of the WAF solution being defined
    class_property! product : String

    # :ditto:
    def self.product(@@product)
    end

    delegate :product, :product?,
      to: self.class

    @@status = [] of HTTP::Status

    # Declaration that returned HTTP status must match
    # the given *status*, otherwise rest of the rules
    # are ignored.
    #
    # ```
    # class Waf::Foo < Waf
    #   valid_status :forbidden
    #   # or
    #   valid_status 403
    # end
    # ```
    #
    # NOTE: Additive - calling this method multiple times
    # will match on ANY of the added values.
    def self.valid_status(status : HTTP::Status)
      @@status << status
    end

    # :ditto:
    def self.valid_status(code : Int32)
      valid_status HTTP::Status.new(code)
    end

    @@headers = {} of String => Regex

    # Declaration that returned HTTP response header *name*
    # must match the given *value* pattern.
    #
    # ```
    # class Waf::Foo < Waf
    #   # exact match, case sensitive
    #   matches_header "Server", "Apache"
    #
    #   # exact match, case insensitive
    #   matches_header "Server", /^apache$/i
    #
    #   # partial match, case insensitive
    #   matches_header "Server", /apache/i
    #
    #   # asserts the pattern for multiple headers at once
    #   matches_header %w(Cookie Set-Cookie), /__unique_id/
    #
    #   # asserts that "X-Foo" header is not empty
    #   matches_header "X-Foo"
    #
    #   # same as above, but for multiple headers at once
    #   matches_header %w(X-Foo X-Bar X-Baz)
    # end
    # ```
    #
    # NOTE: Additive - calling this method multiple times
    # will create an union with the already existing value.
    def self.matches_header(name : String, value : Regex)
      @@headers[name] =
        @@headers[name]?.try(&.+(value)) || value
    end

    # :ditto:
    def self.matches_header(name : String, value : String)
      matches_header name, Regex.new("\\A#{Regex.escape(value)}\\z")
    end

    # :ditto:
    def self.matches_header(names : Enumerable(String), value : Regex | String)
      names.each { |name| matches_header name, value }
    end

    # Declares `self` as matching if any of the given headers
    # is not empty.
    #
    # ```
    # class Waf::Foo < Waf
    #   # asserts that "X-Foo" header is not empty
    #   matches_header "X-Foo"
    #
    #   # same as above, but for multiple headers at once
    #   matches_header %w(X-Foo X-Bar X-Baz)
    # end
    # ```
    #
    # NOTE: Additive - calling this method multiple times
    # will create an union with the already existing value.
    def self.matches_header(name : String | Enumerable(String))
      matches_header name, /.+/
    end

    # Declares `self` as matching if any of the given headers'
    # keys matches the given *value*.
    #
    # ```
    # class Waf::Foo < Waf
    #   matches_any_header_key /X-Foo-\d+/i
    # end
    # ```
    #
    # NOTE: Additive - calling this method multiple times
    # will create an union with the already existing value.
    def self.matches_any_header_key(value : Regex | String)
      matches_header "*any-key*", value
    end

    # Declares `self` as matching if any of the given headers'
    # values matches the given *value*.
    #
    # ```
    # class Waf::Foo < Waf
    #   matches_any_header_value "waf.foo.com"
    # end
    # ```
    #
    # NOTE: Additive - calling this method multiple times
    # will create an union with the already existing value.
    def self.matches_any_header_value(value : Regex | String)
      matches_header "*any-value*", value
    end

    # Declares `self` as matching if any of the given headers'
    # keys OR values matches given *value*.
    #
    # ```
    # class Waf::Foo < Waf
    #   matches_any_header /SuperToughWaf/i
    # end
    # ```
    #
    # NOTE: Additive - calling this method multiple times
    # will create an union with the already existing value.
    def self.matches_any_header(value : Regex | String)
      matches_header "*any-key-value*", value
    end

    @@body : Regex?

    # Declaration that returned HTTP body must match
    # the given *value* pattern.
    #
    # ```
    # class Waf::Foo < Waf
    #   matches_body /<title>403 Forbidden<\/title>/i
    # end
    # ```
    #
    # NOTE: Additive - calling this method multiple times
    # will create an union with the already existing value.
    def self.matches_body(value : Regex)
      @@body =
        @@body.try(&.+(value)) || value
    end
  end
end
