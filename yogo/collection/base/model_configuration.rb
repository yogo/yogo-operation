require 'yogo/collection/base/model'

module Yogo
  module Collection
    module Base
      module ModelConfiguration
        def model_generate
          DataMapper::Model.new
        end
        
        def before_model_generate
        end
        
        def after_model_generate(model)
          model.extend(Base::Model)
        end
        
        def model_update(model)
          model
        end

        def before_model_update(model)
          model
        end

        def after_model_update(model)
          model
        end
      end # ModelConfiguration
    end # base
  end # Collection
end # Yogo