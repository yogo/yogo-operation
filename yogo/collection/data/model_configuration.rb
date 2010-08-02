require 'yogo/collection/data/model'
require 'yogo/collection/data/model_properties'

module Yogo
  module Collection
    class Data
      module ModelConfiguration
        def after_model_generate(model)
          model = super
          model.extend(Data::Model)
          model.send(:include, Data::Model::InstanceMethods)
          model
        end

        def before_model_update(model)
          model = super
          model.properties.clear
          model.properties.instance_variable_get(:@properties).clear #clear out the name index
          # Need to remove relationships too
          model.relationships.clear
          model.validators.clear!
          model
        end
        
        def model_update(model)
          model = super
          schema.reload
          schema.each do |field|
            field.add_to_model(model)
          end
          model
        end

        def after_model_update(model)
          model.extend(Data::ModelProperties)
          model.auto_upgrade!
          model
        end
      end # ModelConfiguration
    end # Data
  end # Collection
end # Yogo