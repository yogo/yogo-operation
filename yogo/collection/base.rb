
require 'yogo/collection/base/collection_repository'
require 'yogo/collection/base/model_configuration'

module Yogo
  module Collection
    module Base
      
      def self.included(base)
        base.extend(Base::CollectionRepository)
      end
      
      include Base::CollectionRepository::InstanceMethods
      include Base::ModelConfiguration
      
      def collection_storage_name
        self.id.to_s
      end
      
      def as_json(options={})
        self.attributes
      end

      def items(*args)
        data_model.all(*args)
      end
      
      def data_model
        @_data_model ||= generate_model
      end
      
      def update_model(model=data_model)
        before_model_update(model)
        model_update(model)
        if block_given?
          yield
        end
        after_model_update(model)
      end
      
      private

      def generate_model
        before_model_generate
        model = model_generate
        after_model_generate(model)
        
        model.collection = self
        update_model(model)
        return model
      end
    end # Base
  end # Collection
end # Yogo