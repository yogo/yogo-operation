require 'yogo/configuration'
require 'yogo/datamapper/model/configuration'
require 'yogo/datamapper/model/common/properties'

require 'dm-types/uuid'
require 'dm-types/yaml'

module Yogo
  module DataMapper
    module Model
      module Stored
        module Configuration
          include ::DataMapper::Resource
          include Dynamic::Configuration
        
          is :remixable
          
          Common::Properties::UUIDKey[self]
          
          property :operation_definitions,       Yaml,       :default => lambda {|*args| []}
        end # Configuration
      end # Stored
    end # Model
  end # DataMapper
end # Yogo