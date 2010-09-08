require 'yogo/support/proc/partial'

module Yogo
  module Operation
    module Restricted
      module ExpectedType
        protected
        attr_accessor :expected_type
        
        def expected_type
          @expected_type ||= Object
        end
      end # Partial
    end # Restricted
  end # Operation
end # Yogo