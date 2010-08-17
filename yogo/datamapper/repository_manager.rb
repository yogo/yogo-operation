module Yogo
  module DataMapper
    module RepositoryManager
      def managed_repository_name
        raise NotImplementedError
      end
      
      def adapter_config
        raise NotImplementedError
      end
      
      def adapter
        begin
          ::DataMapper.repository(managed_repository_name).adapter
        rescue ::DataMapper::RepositoryNotSetupError
          ::DataMapper.setup(managed_repository_name, adapter_config)
          retry
        end
      end
      
      def managed_repository(&block)
        adapter # ensure the adapter get's setup or exists
        if block_given?
          ::DataMapper.repository(managed_repository_name, &block)
        else
          ::DataMapper.repository(managed_repository_name)
        end
      end
      
    end # StorageManager
  end # DataMapper
end # Yogo