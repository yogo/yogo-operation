module Yogo
  module Collection
    module Static
      module ModelConfiguration
        def model_generate
          model_name = self.static_model
          ActiveSupport::Inflector.constantize(model_name)
        end
        
        def before_model_generate
        end
        
        def after_model_generate(model)
          model.storage_names[self.collection_repository_name] = self.collection_storage_name
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
    end # Static
  end # Collection
end # Yogo