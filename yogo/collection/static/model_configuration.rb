module Yogo
  module Collection
    class Static
      module ModelConfiguration
        def model_generate
          model_name = self.static_model
          ActiveSupport::Inflector.constantize(model_name)
        end
        
        def before_model_generate
        end
        
        def after_model_generate(model)
          model
        end
        
        def model_update(model)
          model.extend(Base::ModelCollectionContext) unless model.respond_to?(:current_collection)
        end

        def before_model_update(model)
          model
        end

        def after_model_update(model)
          model
        end
      end # ModelConfiguration
    end # Static
  end # Collection
end # Yogo