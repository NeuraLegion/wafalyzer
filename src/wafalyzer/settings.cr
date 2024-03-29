module Wafalyzer
  class Settings
    # Timeout being used for requests.
    class_property timeout : Time::Span?

    # Maximum number of subsequent redirections.
    class_property redirection_limit = 7

    # No. of additional iterations (after 1st failed request).
    #
    # NOTE: Setting it to `nil` is equivalent to using `payloads.size`,
    # i.e. there will as many request as available payloads.
    class_property fallback_requests_count : Int32?

    # Array of parameter payloads, injected for fallback requests.
    class_property payloads : Array(String) { SupportFS.payloads }

    # Default `User-Agent` string, used when no other was given and the
    # `use_random_user_agent?` is set to `false`.
    class_property default_user_agent : String = "wafalyzer/%s" % VERSION

    # Array of `User-Agent` http header strings, used in cases when the
    # `use_random_user_agent?` is being set to `true`.
    class_property user_agents : Array(String) { SupportFS.user_agents }

    # Setting it to `true` will make `user_agent` property pick a random
    # `User-Agent` string from the `user_agents` array.
    class_property? use_random_user_agent = false

    # Setting it to `true` will disable SSL verification
    class_property? disable_ssl_verification = false

    # Returns `User-Agent` string, sampled from `user_agents` when the
    # `use_random_user_agent?` is set to `true`, or `default_user_agent`
    # otherwise.
    def self.user_agent : String
      use_random_user_agent? ? user_agents.sample : default_user_agent
    end
  end

  class_getter settings = Settings

  # Yields `settings` to the given block.
  def self.configure : Nil
    yield settings
  end
end
