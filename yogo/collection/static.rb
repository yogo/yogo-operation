require 'yogo/collection/data'

module Yogo
  module Collection
    class Static < Data
      require 'yogo/collection/static/model_configuration'
      include Static::ModelConfiguration
      
      property :static_model,     String,     :required => true
      
      def items(*args)
        DataMapper.repository(self.collection_repository_name) do
          data_model.all(*args)
        end
      end
      
      def data_model
        @_data_model ||= generate_model
      end
      
      
    end # Asset
  end # Collection
end # Yogo