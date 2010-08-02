module Yogo
  module Collection
    module Base
      module CollectionRepository
        def default_collection_repository_name
            :collection_data
        end
        
        module InstanceMethods
          def collection_repository_name
            self.class.default_collection_repository_name
          end
          
          def collection_repository
            DataMapper.repository(collection_repository_name)
          end
        end
      end # CollectionRepository
    end # Base
  end # Collection
end # Yogo