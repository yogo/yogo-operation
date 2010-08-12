require 'yogo/collection/data'

module Yogo
  module Collection
    class Static < Data
      require 'yogo/collection/static/model_configuration'
      include Static::ModelConfiguration
      
      property :static_model,     String
      
    end # Asset
  end # Collection
end # Yogo