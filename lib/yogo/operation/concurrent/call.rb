require 'dataflow'

module Yogo
  module Operation
    module Concurrent
      module Call
        include Dataflow
        def call(*args)
          local do |result|
            flow do
              unify result, super(*args)
            end
            result
          end
        end
      end # Call
    end # Concurrent
  end # Operation
end # Yogo