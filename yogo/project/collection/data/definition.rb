module Yogo
  class Project
    class Collection
      module Data
        module Definition
          def dump_definition
            definition = {}
            definition[:properties] = properties.map do |property|
              prop_type = ActiveSupport::Inflector.demodulize(property.class.name)
              prop_name = property.name
              prop_opts = property.options
              {
                :type => prop_type,
                :name => prop_name,
                :options => prop_opts
              }
            end
            
            return definition
          end
          
          def load_definition(definition)
          end
        end # Definition
      end # Data
    end # Collection
  end # Project
end # Yogo