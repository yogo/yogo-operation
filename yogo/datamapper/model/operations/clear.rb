require 'yogo/operation'

module Yogo
  module DataMapper
    module Model
      module Operations
        module Clear
          Properties = Operation.on(::DataMapper::Model) do |model|
            model.properties.clear
            model.properties.instance_variable_get(:@properties).clear #clear out the name index
            model
          end
        
          Relationships = Operation.on(::DataMapper::Model) do |model|
            model.relationships.clear
            model
          end
        
          Validators = Operation.on(::DataMapper::Model) do |model|
            model.validators.clear!
            model
          end
          
          All = Properties * Relationships * Validators
        end # Clear
      end # Operations
    end # Model
  end # DataMapper
end # Yogo