require 'yogo/operation'

module Yogo
  module DataMapper
    module Model
      module Operations
        module Add
          Property = Operation.on(::DataMapper::Model) do |model, name, type, options|
            type ||= String
            options ||= {}
            model.property(name, type, options)
            model
          end
          
          
          Relationship = Operation.on(::DataMapper::Model) do |model, method, *args|
            model.send(method, *args)
            model
          end
          
          HasRelationship = Relationship.partial(X, :has, X, X, X)
          
          HasN = HasRelationship.partial(X, Infinity, X, X)
          
          HasOne = HasRelationship.partial(X, 1, X, X)
          
          BelongsTo = Relationship.partial(X, :belongs_to, X, X)
          
          
        end # Add
      end # Operations
    end # Model
  end # DataMapper
end # Yogo