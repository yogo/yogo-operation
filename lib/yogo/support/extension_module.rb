require 'yogo/support/proc/compose'
module Yogo
  module ExtensionModule
    def extended(base)
      case(base)
      when Class, Module
        base.class_eval(&class_extensions)
      else
        base.instance_eval(&instance_extensions)
      end
    end
    
    def included(base)
      extended(base)
    end
    
    def instance_extensions(&block)
      @_instance_extensions ||= lambda {}
      if block_given?
        @_instance_extensions = block
      end
      @_instance_extensions
    end
    
    def class_extensions(&block)
      @_class_extensions ||= lambda {}
      if block_given?
        @_class_extensions = block
      end
      @_class_extensions
    end
  end # ExtensionModule
end # Yogo