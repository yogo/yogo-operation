module Yogo
  module Collection
    module Base
      module Model
        def to_s
          "CollectionItemModel[]"
        end
        
        
        
        module InstanceMethods
          def as_json(options=nil)
            self.attributes
          end
        end

      end # Model
    end # Base
  end # Collection
end # Yogo