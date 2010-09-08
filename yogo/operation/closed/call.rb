require 'yogo/operation/closed/error'

module Yogo
  module Operation
    module Closed
      module Call
        def call(*args)
          argument = args.first
          result = super(*args)
          unless result.kind_of?(argument.class)
            raise(OperationNotClosedError, :argument => argument, :result => result)
          end
          result
        end
      end # Call
    end # Closed
  end # Operation
end # Yogo