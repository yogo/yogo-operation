module Yogo
  module Collection
    module Base
      module Model
        def to_s
          "CollectionItemModel[#{default_storage_name}]"
        end
        
        def default_repository_name
          self.collection.collection_repository.name
        end
        
        def default_storage_name
          self.collection.collection_storage_name
        end
    
        def collection
          @_collection
        end
    
        def collection=(col)
          @_collection=col
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