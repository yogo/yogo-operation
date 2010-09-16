require 'yogo/support/proc/compose'
require 'yogo/operation/restricted/expected_type'

module Yogo
  module Operation
    module Restricted
      module Compose
        include ExpectedType
        include Yogo::Support::Proc::Compose
        
        # Restricted operations are always expected to accept and return
        # the SAME type of argument. Therefore don't *splat apart the result
        # of the composed operation 'g' as is done in Yogo::Support::Proc::Compose
        def compose(g)
          lambda{|*args| self[g[*args]]}
        end
      end # Partial
    end # Restricted
  end # Operation
end # Yogo