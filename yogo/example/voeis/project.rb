require 'dm-core'
require 'dm-types/uuid'

require 'yogo/datamapper/repository_manager'
require 'yogo/example/voeis/managed/site'
require 'yogo/example/voeis/managed/data_stream'

module Yogo
  module Voeis
    class Project
      include ::DataMapper::Resource
      include Yogo::DataMapper::RepositoryManager
  
      property :id,               UUID,       :key => true, :default => lambda { UUIDTools::UUID.timestamp_create }
      property :name,             String,     :required => true
      property :description,      String
      
      def self.manage(klass)
        @managed_models ||= []
        unless @managed_models.include?(klass)
          @managed_models << klass
        end
        @managed_models
      end
      
      def self.managed_models
        @managed_models
      end
      
      
      def managed_repository_name
        ActiveSupport::Inflector.tableize(id.to_s).to_sym
      end
      
      def adapter_config
        {
          :adapter => 'sqlite',
          :database => "voeis-project-#{managed_repository_name}.db"
        }
      end
      
      def prepare_models
        adapter # ensure the adapter exists or is setup
        managed_repository.scope {
          self.class.managed_models.each do |klass|
            klass.auto_upgrade!
          end
        }
      end
      
      after :save, :prepare_models
      
      manage Managed::Site
      manage Managed::DataStream
    end # Project
  end # Voeis
end # Yogo