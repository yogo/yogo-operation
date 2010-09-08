require 'yogo/operation/restricted/expected_type'

module Yogo
  module Operation
    module Restricted
      module Construction
        def self.included(base)
          raise "Inclusions not allowed. Use: extend(#{self.name})"
        end
      
        def extended(base)
          base.class_eval {
            include ExpectedType
          }
          base.instance_eval {
            protected :new
          }
        end
      
        def on(type, &block)
          op = self.new(&block)
          op.instance_eval{ self.expected_type = type }
          op
        end
      end # Construction
    end # Restricted
  end # Operation
end # Yogo