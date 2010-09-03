require 'yogo/datamapper/dynamic/stored/configuration'


class ProjectRemix
  include ::DataMapper::Resource
  
  property :id,               UUID,       :key => true, :default => lambda { Yogo::Configuration.random_uuid }
  property :name,             String,     :required => true
  
  without_auto_validations do
    remix n, 'Yogo::DataMapper::Dynamic::Stored::Configuration', :as => :model_configurations, :model => 'ProjectModelConfiguration'
    enhance :configuration do
      property :project_id, UUID
    end
  end
end # ProjectRemix
