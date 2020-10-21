require "./matcher"

module Wafalyzer
  abstract class Waf; end

  module Waf::DSL
    include Matcher

    protected getter valid_status = [] of HTTP::Status
    protected getter matches_headers = {} of String => Regex
    protected property matches_body : Regex?

    def initialize
      return unless instance = self.class.instance?

      @valid_status = instance.valid_status.dup
      @matches_headers = instance.matches_headers.dup
      @matches_body = instance.matches_body.dup
    end

    # Declaration that returned HTTP status must match
    # the given *status*, otherwise rest of the rules
    # are ignored.
    #
    # ```
    # class Waf::Foo < Waf
    #   builder do
    #     valid_status :forbidden
    #     # or
    #     valid_status 403
    #   end
    # end
    # ```
    #
    # NOTE: Additive - calling this method multiple times
    # will match on ANY of the added values.
    protected def valid_status(status : HTTP::Status)
      self.valid_status << status
    end

    # :ditto:
    protected def valid_status(code : Int32)
      valid_status HTTP::Status.new(code)
    end

    # Declaration that returned HTTP response header *name*
    # must match the given *value* pattern.
    #
    # ```
    # class Waf::Foo < Waf
    #   builder do
    #     # exact match, case sensitive
    #     matches_header "Server", "Apache"
    #
    #     # exact match, case insensitive
    #     matches_header "Server", /^apache$/i
    #
    #     # partial match, case insensitive
    #     matches_header "Server", /apache/i
    #
    #     # asserts the pattern for multiple headers at once
    #     matches_header %w(Cookie Set-Cookie), /__unique_id/
    #
    #     # asserts that "X-Foo" header is not empty
    #     matches_header "X-Foo"
    #
    #     # same as above, but for multiple headers at once
    #     matches_header %w(X-Foo X-Bar X-Baz)
    #   end
    # end
    # ```
    #
    # NOTE: Additive - calling this method multiple times
    # will create an union with the already existing value.
    protected def matches_header(name : String, value : Regex)
      matches_headers[name] =
        matches_headers[name]?.try(&.+(value)) || value
    end

    # :ditto:
    protected def matches_header(name : String, value : String)
      matches_header name, Regex.new("\\A#{Regex.escape(value)}\\z")
    end

    # :ditto:
    protected def matches_header(names : Enumerable(String), value : Regex | String)
      names.each { |name| matches_header name, value }
    end

    # Declares `self` as matching if any of the given headers
    # is not empty.
    #
    # ```
    # class Waf::Foo < Waf
    #   builder do
    #     # asserts that "X-Foo" header is not empty
    #     matches_header "X-Foo"
    #
    #     # same as above, but for multiple headers at once
    #     matches_header %w(X-Foo X-Bar X-Baz)
    #   end
    # end
    # ```
    #
    # NOTE: Additive - calling this method multiple times
    # will create an union with the already existing value.
    protected def matches_header(name : String | Enumerable(String))
      matches_header name, /.+/
    end

    # Declares `self` as matching if any of the given headers'
    # keys matches the given *value*.
    #
    # ```
    # class Waf::Foo < Waf
    #   builder do
    #     matches_any_header_key /X-Foo-\d+/i
    #   end
    # end
    # ```
    #
    # NOTE: Additive - calling this method multiple times
    # will create an union with the already existing value.
    protected def matches_any_header_key(value : Regex | String)
      matches_header "*any-key*", value
    end

    # Declares `self` as matching if any of the given headers'
    # values matches the given *value*.
    #
    # ```
    # class Waf::Foo < Waf
    #   builder do
    #     matches_any_header_value "waf.foo.com"
    #   end
    # end
    # ```
    #
    # NOTE: Additive - calling this method multiple times
    # will create an union with the already existing value.
    protected def matches_any_header_value(value : Regex | String)
      matches_header "*any-value*", value
    end

    # Declares `self` as matching if any of the given headers'
    # keys OR values matches given *value*.
    #
    # ```
    # class Waf::Foo < Waf
    #   builder do
    #     matches_any_header /SuperToughWaf/i
    #   end
    # end
    # ```
    #
    # NOTE: Additive - calling this method multiple times
    # will create an union with the already existing value.
    protected def matches_any_header(value : Regex | String)
      matches_header "*any-key-value*", value
    end

    # Declaration that returned HTTP body must match
    # the given *value* pattern.
    #
    # ```
    # class Waf::Foo < Waf
    #   builder do
    #     matches_body /<title>403 Forbidden<\/title>/i
    #   end
    # end
    # ```
    #
    # NOTE: Additive - calling this method multiple times
    # will create an union with the already existing value.
    protected def matches_body(value : Regex)
      self.matches_body =
        matches_body.try(&.+(value)) || value
    end
  end
end
