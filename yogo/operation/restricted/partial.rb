require 'yogo/support/proc/partial'
require 'yogo/operation/restricted/expected_type'

module Yogo
  module Operation
    module Restricted
      module Partial
        include ExpectedType
        
        def partial(*args)
          applied = super(*args)
          self.class.on(self.expected_type, &applied)
        end
      end # Partial
    end # Restricted
  end # Operation
end # Yogo