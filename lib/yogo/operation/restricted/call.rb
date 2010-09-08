require 'yogo/operation/restricted/error'
require 'yogo/operation/restricted/expected_type'

module Yogo
  module Operation
    module Restricted
      module Call
        include ExpectedType
        
        def call(*args)
          argument = args.first
          unless argument.kind_of?(expected_type)
            raise(OperationRestrictionError, :argument => argument, :expected_type => expected_type)
          end
          super
        end
      end # Call
    end # Closed
  end # Operation
end # Yogo