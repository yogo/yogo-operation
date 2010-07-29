module Yogo
  class Collection
    module Data
      module Definition
        def dump_definition
          definition = {}
          definition['properties'] = {}
          properties.each do |property|
            prop_type = ActiveSupport::Inflector.demodulize(property.class.name)
            prop_name = property.name.to_s
            prop_opts = property.options
            definition['properties'][prop_name] = {
              'type' => prop_type,
              'options' => prop_opts
            }
          end
          
          return definition
        end
        
        def load_definition(definition)
          properties.clear
          properties.instance_variable_get(:@properties).clear #clear out the name index
          
          definition['properties'] ||= {}
          definition['properties'].each do |name, config|
            options = (config['options'] || {}).inject({}) {|opts, (k,v)| opts[k.to_sym] = v; opts}
            #TODO: DataMapper::Property.find_const should really be replaced by DataMapper::property.find_class in master
            puts name.inspect, config.inspect
            property(name.to_sym, DataMapper::Property.find_const(config['type']), options)
          end
        end
      end # Definition
    end # Data
  end # Collection
end # Yogo