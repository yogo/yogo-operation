require 'dm-core'
require 'dm-validations'
require 'dm-types/uuid'
require 'dm-timestamps'

require 'yogo/configuration'
require 'yogo/collection/base'
require 'yogo/collection/data/model_configuration'
require 'yogo/collection/property'

module Yogo
  module Collection
    class Data
      include DataMapper::Resource
      
      
      property :id,               UUID,       :key => true, :default => lambda { Yogo::Configuration.random_uuid }
      property :name,             String,     :required => true
      property :description,      String
      property :type,             Discriminator
      
      property   :project_id,     UUID
      belongs_to :project, :model => 'Yogo::Project'
      
      validates_uniqueness_of :name, :scope => :project_id
      
      has n, :schema, :model => 'Yogo::Collection::Property', :child_key => [:data_collection_id]
      
      include Collection::Base
      include Data::ModelConfiguration
      
      chainable do
        def as_json
          {
            :id => self.id.to_s,
            :name => self.name,
            :description => self.description,
            :type => self.type.to_s,
            :project => self.project_id.to_s,
            :schema => self.schema.map{|p| p.id.to_s }
          }
        end
        
        def update_attributes(hash)
          attrs = {}
          attrs[:name] = hash[:name] || hash['name'] || self.name
          attrs[:description] = hash[:description] || hash['description'] || self.description
          attrs[:type] = hash[:type] || hash['type'] || self.type || self.class.name
          self.attributes = attrs
        end
      end
      
      protected

      def resolve_property(options)
        schema.first(options)
      end

    end # Base
  end # Collection
end # Yogo