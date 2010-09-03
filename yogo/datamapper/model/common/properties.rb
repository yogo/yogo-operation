require 'yogo/operation'
require 'yogo/datamapper/model/operations/add'
require 'dm-types/uuid'

module Yogo
  module DataMapper
    module Model
      module Common
        module Properties
          UUIDKey = Operations::Add::Property.partial(X, :id, ::DataMapper::Property::UUID, {:key => true, :default => lambda{|*args| UUIDTools::UUID.timestamp_create}})
          
        end # Properties
      end # Common
    end # Model
  end # DataMapper
end # Yogo