require 'dm-core'
require 'dm-types/uuid'
require 'yogo/collection'

module Yogo
  class Project
    include DataMapper::Resource
    
    property :id,               UUID,       :key => true, :default => lambda { UUIDTools::UUID.timestamp_create }
    property :name,             String,     :required => true
    property :description,      Text
    
    has n,   :data_collections, :model => 'Yogo::Collection::Data', :child_key => [:project_id]
  end # Project
end # Yogo