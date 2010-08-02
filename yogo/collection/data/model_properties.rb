module Yogo
  module Collection
    class Data
      module ModelProperties
        def self.extended(model)
          model.class_eval do
            property :id,           UUID, :key => true, :default => lambda { UUIDTools::UUID.timestamp_create }
            property :created_at,   DateTime
            property :updated_at,   DateTime
          end
        end
      end # ModelProperties
    end # Base
  end # Collection
end # Yogo