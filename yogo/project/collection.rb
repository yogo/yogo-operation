require 'dm-types'
require 'yogo/project'

module Yogo
  class Project
    class Collection
      include DataMapper::Resource
      
      property :id,         UUID
      property :name,       String,     :required => true
      property :description,  Text
      
      belongs_to  :project,     Yogo::Project
      
    end # Collection
  end # Project
end # Yogo