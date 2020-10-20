require "./waf/*"

module Wafalyzer
  abstract class Waf
    Log = ::Log.for(self)

    # Array of loaded `Waf` profiles
    class_property instances = {} of Waf.class => Waf

    # Returns an array of `Waf` profiles matching the given *response*.
    def self.detect(response : HTTP::Client::Response) : Array(Waf)
      Waf.instances.each_with_object([] of Waf) do |(_, waf), matches|
        matches << waf if waf.matches?(response)
      end
    end

    # Registers `self` with given properties.
    #
    # ```
    # class Waf::Foo < Waf
    #   register product: "Foo WAF"
    # end
    # ```
    def self.register(*args, **kwargs)
      Waf.instances[self] = new(*args, **kwargs)
    end

    def self.find?(klass : Waf.class) : Waf?
      Waf.instances[klass]?
    end

    def self.find(klass : Waf.class) : Waf
      find?(klass) ||
        raise ArgumentError.new("Cannot find the Waf instance for given class #{klass}")
    end

    def self.instance? : Waf?
      find?(self)
    end

    def self.instance : Waf
      find(self)
    end

    def self.builder
      with instance yield instance
    end

    include DSL

    # Full name of the WAF solution being defined
    property product : String

    def initialize(@product)
      super()
    end

    def initialize
      initialize(self.class.instance.product)
    end

    def_clone

    def to_s(io : IO) : Nil
      io << product
    end

    def to_json(json : JSON::Builder)
      {product: product}.to_json(json)
    end
  end
end

require "./wafs/*"
