require 'yogo/collection/data/definition'

module Yogo
  module Collection
    module Data
      module Model
        def self.included(base)
          base.extend(ClassMethods)
          base.extend(Data::Definition)
        end
        
        def get_by_name(name)
          managing_collection = self.class.collection
          resolved_name = managing_collection.resolve_property_by_name(name)
          resolved_name ? get_attribute(resolved_name.intern) : nil
        end
        
        module CoreProperties
          def self.included(base)
            base.class_eval do
              property :id,           UUID, :key => true, :default => lambda { UUIDTools::UUID.timestamp_create }
              property :created_at,   DateTime
              property :updated_at,   DateTime
            end
          end
        end
              
        module ClassMethods
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
          
        end # ClassMethods
      end # Model
    end # Data
  end # Collection
end # Yogo