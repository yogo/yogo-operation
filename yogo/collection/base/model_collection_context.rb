require 'yogo/collection'

module Yogo
  module Collection
    module Base
      module ModelCollectionContext
        def current_collection
          Yogo::Collection.context.last
        end
        
        def collection
          current_collection
        end
        
        def default_storage_name
          (current_collection && current_collection.collection_storage_name) || super
        end
        
        def default_repository_name
          (current_collection && current_collection.collection_repository_name) || super
        end
      end # ModelCollectionContext
    end # Static
  end # Collection
end # Yogo