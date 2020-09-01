module Wafalyzer
  class SupportFS
    private SUPPORT_PATH = Path[__DIR__, "..", "support"]

    def self.read_file(path : String | Path) : String
      File.read(SUPPORT_PATH / path)
    end

    protected def self.compact_lines(content : String) : Array(String)
      content.lines.compact!
    end

    def self.payloads : Array(String)
      compact_lines read_file("payloads.txt")
    end

    def self.user_agents : Array(String)
      compact_lines read_file("user_agents.txt")
    end
  end
end
