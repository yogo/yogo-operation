require 'yogo/operation/error'

module Yogo
  module Operation
    module Closed
      class OperationNotClosedError < OperationError
        def_delegators :information, :expected_type, :argument, :result
        def initialize(options)
          options[:message] ||= "The Operation is not closed! The argument and result of the operation were not of the same type."
          options[:expected_type] ||= options[:argument].class
          super(options)
        end
      end # OperationNotClosedError
    end # Closed
  end # Operation
end # Yogo