require 'dm-validations'
require 'dm-types'
require 'dm-serializer'
require 'dm-is-remixable'
require 'uuidtools'

require 'yogo/collection/core'
require 'yogo/collection/manager'
require 'yogo/collection/data/model'
require 'yogo/property_ext'
require 'yogo/schema'

module Yogo
  module Collection
    include DataMapper::Resource
    is :remixable,
       :suffix => 'collection'
    
    property :id,               UUID,       :key => true, :default => lambda { UUIDTools::UUID.timestamp_create }
    property :name,             String,     :required => true
    property :description,      Text
    
    property :collection_storage_name,     String, :default => lambda { UUIDTools::UUID.timestamp_create.to_s }
    
    
    RemixerClassMethods = Yogo::Collection::Manager::ClassMethods
    RemixerInstanceMethods = Yogo::Collection::Manager::InstanceMethods
    RemixeeClassMethods = Yogo::Collection::Core::ClassMethods
    RemixeeInstanceMethods = Yogo::Collection::Core::InstanceMethods
    
    
    
    

    
    
    
    

  end # Collection
end # Yogo