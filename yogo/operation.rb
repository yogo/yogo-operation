require 'facets/proc/curry'
require 'facets/proc/compose'

X = :partial_unspecified_argument

module Yogo
  class Operation < Proc
    
    def self.on(type, &block)
      op = self.new(&block)
      op.instance_eval{ self.type = type }
      op
    end
    
    def call(*args)
      x = args.first
      raise "Can only invoke on #{type}" if type && !x.is_a?(type)
      super(*args)
    end
    
    
    
    private
    attr_accessor :type
  end # Operation
  
  class ::Proc
    def partial(*args)
      Proc.new do |*spice|
        result = args.collect do |a|
          X == a ? spice.shift : a
        end
        call(*result)
      end
    end
  end
  
  module Operations
    def self.[](op_name)
      op_name.split("::").reduce(self) do |namespace, const|
        if namespace && namespace.const_defined?(const)
          namespace.const_get(const)
        else
          nil
        end
      end
    end
  end
end # Yogo