require 'dm-core'
require 'dm-types/uuid'
require 'dm-types/yaml'

require 'yogo/collection/property'
require 'yogo/collection/field_view'

module Yogo
  module Collection
    class Form
      include DataMapper::Resource
      
      property  :id,      UUID,         :key => true, :default => lambda { Yogo::Configuration.random_uuid }
      property  :name,   String,        :required => true
      
      belongs_to  :collection
      has n,      :field_views
      has n,      :fields,            :through => :field_views
      has n,      :available_fields,  :through => :collection, :model => 'Yogo::Collection::Property'
    end # FieldView
  end # Collection
end # Yogo