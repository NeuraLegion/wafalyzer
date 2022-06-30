module Wafalyzer
  class Waf::Cerber < Waf
    register product: "Cerber (WordPress)"

    PATTERN = Regex.union([
    /We're sorry, you are not allowed to proceed\<\/h1\>/,
    /\<p\>Your request looks suspiciously similar to automated requests from spam posting software or it has been denied by a security policy configured by the website administrator\.\<\/p\>/
    ])


    builder do
      matches_body PATTERN
    end
  end
end
