module Yogo
  module Support
    module Proc
      module Call
        def [](*args)
          call(*args)
        end
      end # Call
    end # Proc
  end # Support
end # Yogo