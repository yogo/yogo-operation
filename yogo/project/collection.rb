require 'dm-types'
require 'yogo/project'
require 'yogo/project/collection/data/model'

module Yogo
  class Project
    class Collection
      include DataMapper::Resource
      
      property :id,         Serial
      property :name,       String,     :required => true
      property :description,  Text
      
      belongs_to  :project,     Yogo::Project
      
      
      def data_repository
        project.data_repository
      end
      
      def data
        @_data_model ||= generate_model
      end
      
      private
      
      def generate_model
        model = DataMapper::Model.new
        model.send(:include, Data::Model)
        model.project_collection = self
        
        return model
      end
    end # Collection
  end # Project
end # Yogo