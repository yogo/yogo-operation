require 'dm-core'
require 'dm-types/uuid'
require 'yogo/collection'

module Yogo
  class Project
    include DataMapper::Resource
    
    property :id,               UUID,       :key => true, :default => lambda { UUIDTools::UUID.timestamp_create }
    property :name,             String,     :required => true
    property :description,      String
    
    has n,   :data_collections, :model => 'Yogo::Collection::Data', :child_key => [:project_id]
    
    chainable do
      def as_json(options={})
        {
          :id => self.id.to_s,
          :name => self.name,
          :description => self.description,
          :data_collections => self.data_collections.map{|c| c.id.to_s }
        }
      end
      
      def update_attributes(hash)
        attrs = {}
        attrs[:name] = hash[:name] || hash['name'] || self.name
        attrs[:description] = hash[:description] || hash['description'] || self.description
      end
    end
  end # Project
end # Yogo