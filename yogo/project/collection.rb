require 'dm-types'
require 'uuidtools'

require 'yogo/project'
require 'yogo/project/collection/data/model'
require 'yogo/project/property_ext'

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
          'properties' => data_properties.dup
        }
      end
      
      def data_definition=(definition)
        props = definition['properties'] || {}
        props['id'] ||= {'type' => "Serial"}
        self.data_properties = props.dup
        update_model
        data_definition
      end
      
      # after(:data_definition=) do
      #         update_model
      #       end
      
      protected
      
      property :data_storage_name,     String, :default => UUIDTools::UUID.timestamp_create.to_s
      property :data_properties,       Json, :default => {'id' => { 'type' => "Serial" }}.to_json
      
      private
      
      def as_json(options={})
        options[:exclude] = Array(options[:exclude])
        options[:exclude] << :data_properties << :data_storage_name
        
        options[:methods] = Array(options[:methods])
        options[:methods] << :data_definition
        super(options)
      end
      
      def generate_model
        model = DataMapper::Model.new
        model.send(:include, Data::Model)
        model.project_collection = self
        model.load_definition(data_definition)
        model.auto_upgrade!
        return model
      end
      
      def update_model
        model = data
        model.load_definition(data_definition)
        model.auto_upgrade!
      end
    end # Collection
  end # Project
end # Yogo