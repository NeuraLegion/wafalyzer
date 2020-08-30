module Wafalyzer
  class Settings
    private SUPPORT_PATH = Path[__DIR__, "..", "support"]

    class_property timeout : Time::Span?
    class_property default_user_agent : String = "wafalyzer/%s" % VERSION
    class_property user_agents : Array(String) {
      File
        .read_lines(SUPPORT_PATH / "user_agents.txt")
        .compact!
    }
    class_property? use_random_user_agent = false

    def self.user_agent : String
      use_random_user_agent? ? user_agents.sample : default_user_agent
    end
  end

  class_getter settings = Settings

  def self.configure : Nil
    yield settings
  end
end
