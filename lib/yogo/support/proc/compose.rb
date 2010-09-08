module Yogo
  module Support
    module Proc
      module Compose
        def compose(g)
          raise ArgumentError, "arity count mismatch" unless arity == g.arity
          lambda{|*args| self[*g[*args]] }
        end
  
        def *(x)
          if Integer===x
            c = []
            x.times{|i| c << call(i)}
            c
          else
            compose(x)
          end
        end
      end # Compose
    end # Proc
  end # Support
end # Yogo