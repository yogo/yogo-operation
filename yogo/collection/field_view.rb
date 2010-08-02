require 'dm-core'
require 'dm-types/uuid'
require 'dm-types/yaml'

require 'yogo/collection/field'
require 'yogo/collection/form'

module Yogo
  module Collection
    class FieldView
      include DataMapper::Resource
      
      property  :id,      UUID,         :key => true, :default => lambda { UUIDTools::UUID.timestamp_create }
      property  :label,   String,       
      property  :type,    String,       :required => true, :default => 'textfield'
      property  :options, Yaml,         :default => {}.to_yaml
      
      belongs_to :field
      belongs_to :form
      
      def label
        ActiveSupport::Inflector.titleize(attribute_get(:label) || field.field_name || '')
      end
    end # FieldView
  end # Collection
end # Yogo