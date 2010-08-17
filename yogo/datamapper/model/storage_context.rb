module Yogo
  module DataMapper
    module Model
      module StorageContext
        def storage_name(*args)
          [super, Thread.current[:yogo_storage_name]].flatten.compact.join('_')
        end
      end # ManagedContext
    end # Model
  end # DataMapper
end # Yogo