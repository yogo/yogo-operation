require 'dm-core'
require 'dm-validations'
require 'dm-types/uuid'
require 'dm-serializer'
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
      property :description,      Text
      property :type,             Discriminator
      
      property   :project_id,     UUID
      belongs_to :project, :model => 'Yogo::Project'
      
      has n, :schema, :model => 'Yogo::Collection::Property', :child_key => [:data_collection_id]
      
      include Collection::Base
      include Data::ModelConfiguration
      
      protected

      def resolve_property(options)
        schema.first(options)
      end


    end # Base
  end # Collection
end # Yogo