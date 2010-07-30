require 'dm-core'
require 'dm-validations'
require 'dm-types/uuid'
require 'dm-serializer'
require 'dm-timestamps'

require 'yogo/collection/data/model'
require 'yogo/collection/property'

module Yogo
  class Collection
    include DataMapper::Resource
    
    property :id,               UUID,       :key => true, :default => lambda { UUIDTools::UUID.timestamp_create }
    property :name,             String,     :required => true
    property :description,      Text
  
    property :collection_storage_name,     String, :default => lambda { UUIDTools::UUID.timestamp_create.to_s }

    has n, :schema, :model => 'Yogo::Collection::Property', :child_key => [:data_collection_id]
    
    property   :project_id,     UUID
    belongs_to :project, :model => 'Yogo::Project'
    
    def self.default_collection_repository_name
      :collection_data
    end
    
    def collection_repository
      DataMapper.repository(collection_repository_name)
    end

    def data_model
      @_data_model ||= generate_model
    end
    

    def items(*args)
      data_model.all(*args)
    end
    
    protected
    
    def resolve_property(options)
      schema.first(options)
    end
    
    private
    
    def collection_repository_name
      self.class.default_collection_repository_name
    end
    
    # def method_missing(method, *args, &block)
    #   
    # end

    def generate_model
      model = DataMapper::Model.new
      model.send(:include, Data::Model)
      model.collection = self

      update_model(model)
      return model
    end

    def update_model(model=data_model)
      model.properties.clear
      model.properties.instance_variable_get(:@properties).clear #clear out the name index
      
      schema.reload
      schema.each do |field|
        field.add_to_model(model)
      end
      
      model.send(:include, Data::Model::CoreProperties)

      model.auto_upgrade!
      return model
    end
  end # Collection
end # Yogo