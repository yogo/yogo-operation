require 'yogo/datamapper/model/storage_context'

module Yogo
  module DataMapper
    module StorageManager
      def managed_storage_name
        raise NotImplementedError
      end
      
      def activate_storage
        Thread.current[:yogo_storage_name] = managed_storage_name
        ::DataMapper.auto_upgrade!   
        reload
      end
      
      def deactivate_storage
        Thread.current[:yogo_storage_name] = nil
        ::DataMapper.auto_upgrade!
        reload
      end
      
      def with_storage(&block)
        activate_storage
        yield(self)
        deactivate_storage
      end
    end # StorageManager
  end # DataMapper
end # Yogo