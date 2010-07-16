require 'dm-core'
require 'dm-validations'
require 'dm-types'
require 'yogo/project/collection'

module Yogo
  class Project
    include DataMapper::Resource
    
    property :id,           Serial
    property :name,         String,   :required => true,
                                      :unique   => true
    property :description,  Text,     :required => false
    
    validates_uniqueness_of :name
    
    has n, :collections, Yogo::Project::Collection
    
    def data_repository
      DataMapper.repository(data_repository_name)
    end
    
    private
    
    def self.default_data_repository_name
      :project_data
    end
    
    def data_repository_name
      self.class.default_data_repository_name
    end
    
    
      
  end
end # Yogo