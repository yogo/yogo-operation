require 'yogo/operation'

module Yogo
  module DataMapper
    module Model
      module Operations
        module Clear
          Properties = Op.on(::DataMapper::Model) do |model|
            model.properties.clear
            model.properties.instance_variable_get(:@properties).clear #clear out the name index
            model
          end
        
          Relationships = Op.on(::DataMapper::Model) do |model|
            model.relationships.clear
            model
          end
        
          Validators = Op.on(::DataMapper::Model) do |model|
            model.validators.clear!
            model
          end
          
          All = Properties * Relationships * Validators
        end # Clear
      end # Operations
    end # Model
  end # DataMapper
end # Yogo