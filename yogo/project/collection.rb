require 'dm-types'
require 'uuidtools'

require 'yogo/project'
require 'yogo/project/collection/data/model'

module Yogo
  class Project
    class Collection
      include DataMapper::Resource
      
      property :id,               Serial
      property :name,             String,     :required => true
      property :description,      Text
      
      belongs_to  :project,       Yogo::Project
      
      def data_repository
        project.data_repository
      end
      
      def data
        @_data_model ||= generate_model
      end
      
      def data_definition
        {
          :properties => {}.merge!(data_properties)
        }
      end
      
      def data_definition=(definition)
        data_properties = definition[:properties] || {}
      end
      
      after(:data_definition=) do
        update_model
      end
      
      protected
      
      property :data_storage_name,     String, :default => UUIDTools::UUID.timestamp_create.to_s
      property :data_properties,       Json, :default => {}.to_json
      
      private
      
      def generate_model
        model = DataMapper::Model.new
        model.send(:include, Data::Model)
        model.project_collection = self
        model.load_definition(data_definition)
        return model
      end
      
      def update_model
        model = data
        model.load_definition(data_definition)
      end
    end # Collection
  end # Project
end # Yogo