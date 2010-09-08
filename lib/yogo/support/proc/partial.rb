X = :partial_unspecified_argument

module Yogo
  module Support
    module Proc
      module Partial
        def partial(*args)
          ::Proc.new do |*spice|
            result = args.collect do |a|
              X == a ? spice.shift : a
            end
            call(*result)
          end
        end
      end # Partial
    end # Proc
  end # Support
end # Yogo