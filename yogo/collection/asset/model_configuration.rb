require 'yogo/collection/asset/model'
require 'yogo/collection/asset/model_properties'

module Yogo
  module Collection
    class Asset < Data
      module ModelConfiguration        
        def after_model_generate(model)
          model = super
          model.extend(Asset::Model)
          model
        end
        
        def after_model_update(model)
          model.extend(Asset::ModelProperties)
          super
        end
      end # ModelConfiguration
    end # Data
  end # Collection
end # Yogo