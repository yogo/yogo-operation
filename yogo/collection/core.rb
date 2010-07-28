require 'yogo/schema'
require 'dm-is-list'
require 'deep_merge'

module Yogo
  module Collection
    module Core
      module InstanceMethods
        def self.included(collection)
          collection_field = ActiveSupport::Inflector.foreign_key(collection.name).intern
          
          collection.class_eval do
            remix n, Yogo::Schema, :as => "all_schemas"
            
            enhance :schema do
              validators.clear!
              property collection_field,  DataMapper::Property::UUID
              is :list, :scope => collection_field
            end
          end
        end

        def collection_repository
          DataMapper.repository(collection_repository_name)
        end

        def data_model
          @_data_model ||= generate_model
        end
        
        def schemas(options={})
          all_schemas.all({:order => [:position]}.merge(options))
        end

        def items(*args)
          data_model.all(*args)
        end
        
        protected
        
        def resolve_property_by_name(name)
          found = data_model_definition(:name)[:properties][name]
          found ? found['id'] : nil
        end
        
        private
        
        def collection_repository_name
          self.class.default_collection_repository_name
        end
      
        def data_model_definition(by=:id)
          composed_schema = {}
          schemas.reload
          schemas.each do |schema|
            schema_hash = schema.to_hash(by)
            composed_schema.deep_merge!(schema_hash)
          end
          composed_schema
        end

        def generate_model
          model = DataMapper::Model.new
          model.send(:include, Data::Model)
          model.collection = self
          model.load_definition(data_model_definition)
          model.send(:include, Data::Model::CoreProperties)
          model.auto_upgrade!
          return model
        end

        def update_model
          model = data
          model.load_definition(data_model_definition)
          model.send(:include, Data::Model::CoreProperties)
          model.auto_upgrade!
        end
      end # InstanceMethods
    
      module ClassMethods
        def default_collection_repository_name
          'collection_data'
        end
      end # ClassMethods
    end # Core
  end # Collection
end # Yogo