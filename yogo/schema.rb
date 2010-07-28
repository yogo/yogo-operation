require 'dm-is-remixable'
require 'yogo/field'
require 'dm-is-list'

module Yogo
  module Schema
    include DataMapper::Resource
    is :remixable,
       :suffix => 'schema'
    
    property  :id,      UUID,       :key => true, :default => lambda { UUIDTools::UUID.timestamp_create }
    property  :name,    String,     :required => true
    
    module RemixeeInstanceMethods
      def self.included(remixed_schema)
        prop_model_name = ActiveSupport::Inflector.classify(remixed_schema.name.underscore + '_' + 'property')
        rel_model_name = ActiveSupport::Inflector.classify(remixed_schema.name.underscore + '_' + 'relationship')
        schema_field = ActiveSupport::Inflector.foreign_key(remixed_schema.name).intern
        
        remixed_schema.class_eval do
          remix n,  Yogo::Field, 
                    :as => "all_schema_properties",
                    :model => prop_model_name
                                
          remix n,  Yogo::Field, 
                    :as => "all_schema_relationships",
                    :model => rel_model_name
          
          enhance :field, prop_model_name do
            validators.clear!
            property :options,        DataMapper::Property::Json,   :default => {}.to_json
            property schema_field,    DataMapper::Property::UUID
            is :list, :scope => schema_field
          end
          
          enhance :field, rel_model_name do
            validators.clear!
            property :cardinality,    DataMapper::Property::Enum[:one, :many], :default => :one
            property schema_field,    DataMapper::Property::UUID
            is :list, :scope => schema_field
          end
          
        end
        
        
      end
      
      def schema_properties(options={})
        all_schema_properties.all({:order => [:position]}.merge(options))
      end
      
      def schema_relationships(options={})
        all_schema_relationships({:order => [:position]}.merge(options))
      end
      
      def to_hash(by=:id)
        schema = {}
        props = schema['properties'] = {}
        rels = schema['relationships'] = {}
        
        schema_properties.each do |field|
          key = field.send(by).to_s
          
          if by == :id
            key = 'prop_' + key.gsub('-','_')
          end
          
          prop = props[key] = {}
          prop['name'] = field.name
          prop['type'] = field.type
          prop['options'] = field.options
        end
        
        schema_relationships.each do |field|
          key = field.send(by).to_s
          rel = rels[key] = {}
          rel['id'] = field.id.to_s
          rel['name'] = field.name
          rel['type'] = field.type
          rel['cardinality'] = field.cardinality
        end
        
        schema
      end
    end # RemixeeInstanceMethods
  end # Schema
end # Yogo