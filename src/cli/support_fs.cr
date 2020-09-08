module Wafalyzer
  class SupportFS
    extend BakedFileSystem

    bake_folder "../support"

    def self.read_file(path : String | Path) : String
      get(path.to_s).gets_to_end
    end
  end
end
