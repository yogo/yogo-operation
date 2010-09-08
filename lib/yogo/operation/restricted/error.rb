require 'yogo/operation/error'

module Yogo
  module Operation
    module Restricted
      class OperationRestrictionError < OperationError
        def_delegators :information, :expected_type, :argument, :actual_type
        
        def initialize(options)
          options[:message] ||= "The Operation cannot be applied to an argument of this type!"
          super(options)
        end
      end # OperationNotClosedError
    end # Closed
  end # Operation
end # Yogo