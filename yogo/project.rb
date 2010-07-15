require 'dm-core'
require 'dm-validations'
require 'dm-types'
require 'yogo/project/collection'

module Yogo
  class Project
    include DataMapper::Resource
    
    property :id,           UUID
    property :name,         String,   :required => true,
                                      :unique   => true
    property :description,  Text,     :required => false
    
    validates_uniqueness_of :name
    
    has n, :collections, Yogo::Project::Collection
    
    def self.default_data_repository_name
      :project_data
    end
  end
end # Yogo