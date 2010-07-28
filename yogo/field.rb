require 'dm-types'
require 'dm-is-list'
require 'dm-is-remixable'

module Yogo
  module Field
    include DataMapper::Resource
    is :remixable,
       :suffix => 'field'
    
    property :id,       UUID,       :key => true, :default => lambda { UUIDTools::UUID.timestamp_create }
    
    property  :name,    String,       :required => true
    property  :type,    String,       :required => true, :default => 'String'
    property  :hidden,  Boolean,      :default => false
    
  end # View
end # Yogo