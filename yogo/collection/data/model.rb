require 'dm-timestamps'

module Yogo
  module Collection
    class Data
      module Model 
        def to_s
          "DataItemModel[]"
        end
        
        def resolve_property(options)
          collection.send(:resolve_property, options)
        end

        
        module InstanceMethods
          def self.included(base)
            base.class_eval do
              alias_method :[], :named_attribute_get
              alias_method :[]=, :named_attribute_set
            end
          end
          
          def as_json(options=nil)
            hash = super
            hash[:id] = self.id.to_s
            hash
          end
          
          def named_attribute_get(name)
            name = name.to_s
            property = resolve_property(:name => name)
            property ? attribute_get(property.to_s) : attribute_get(name)
          end

          def named_attribute_set(name, value)
            name = name.to_s
            property = resolve_property(:name => name)
            property ? attribute_set(property.to_s, value) : attribute_set(name, value)
          end
          
          def named_attributes
            attributes.inject({}) do |h,(k,v)|
              if k.to_s =~ /^field_/
                key = k.to_s.gsub(/^field_/,'').gsub('_','-')
                property = resolve_property(:id => key)
                h[property.name] = v
              end
              h
            end
          end
          
          def named_attributes=(attrs)
            attrs = attrs.inject({}) do |h,(k,v)|
              property = resolve_property(:name => k.to_s)
              if(property)
                h[property.to_s.intern] = v
              end
              h
            end
            self.attributes = attrs
          end
          
          def resolve_property(options)
            self.class.resolve_property(options)
          end
          
        end # InstanceMethods
      end # Model
    end # Data
  end # Collection
end # Yogo