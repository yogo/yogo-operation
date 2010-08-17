require 'dm-core'
require 'dm-types/uuid'

require 'yogo/datamapper/storage_manager'
require 'yogo/example/voeis/site'
require 'yogo/example/voeis/data_stream'

module Yogo
  module Example
    module Voeis
      class Project
        include ::DataMapper::Resource
        include Yogo::DataMapper::StorageManager
    
        property :id,               UUID,       :key => true, :default => lambda { UUIDTools::UUID.timestamp_create }
        property :name,             String,     :required => true
        property :description,      String
        
        has n, :sites, :model => 'Yogo::Example::Voeis::Site'
        
        def managed_storage_name
          ActiveSupport::Inflector.tableize(id.to_s)
        end
        
      end # Project
    end # Voeis
  end # Example
end # Yogo