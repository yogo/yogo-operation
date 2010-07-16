module Yogo
  class Project
    class Collection
      module Data
        module Definition
          def dump_definition
            definition = {}
            definition[:properties] = {}
            properties.each do |property|
              prop_type = ActiveSupport::Inflector.demodulize(property.class.name)
              prop_name = property.name
              prop_opts = property.options
              definition[:properties][prop_name] = {
                :type => prop_type,
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