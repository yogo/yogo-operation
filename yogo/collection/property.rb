require 'dm-types/uuid'
require 'dm-types/yaml'

require 'yogo/configuration'

module Yogo
  module Collection
    class Property
      include DataMapper::Resource

      property  :id,      UUID,         :key => true, :default => lambda { Configuration.random_uuid }
      property  :name,    String,       :required => true
      property  :options, Yaml,         :default => {}.to_yaml
      property  :type,    Discriminator
      
      property   :data_collection_id, UUID
      belongs_to :data_collection, :model => 'Yogo::Collection::Data'
      
    
      def field_name
        self.name
      end
    
      def to_s
        'field_' + self.id.to_s.gsub('-','_')
      end
      
      def model_method
        :property
      end
      
      def add_to_model(model)
        prop_name = self.to_s.intern
        prop_type = self.class
        prop_options   = self.options || {}
        
        model.send(model_method, prop_name, prop_type, prop_options)
      end
      
      class String < self; end
      class Integer < self; end
      
    end # Property
    
    
    class Relationship < Property
      property :target,       String
      property :cardinality,  Integer,    :default => 1
      
      def model_method
        :has
      end
      
      def check_target
        raise ":target not set" unless self.target && !self.target.empty?
      end
      
      def add_to_model(model)
        check_target
        model.send(model_method, cardinality, ActiveSupport::Inflector.tableize(self.target).intern, self.options)
      end
      
      class ManyToMany < self; end
      
      class OneToMany < self; end
      
      class OneToOne < self; end
      
      class ManyToOne < self
        def model_method
          :belongs_to
        end
        
        def add_to_model(model)
          check_target
          model.send(model_method, ActiveSupport::Inflector.underscore(self.target).intern, self.options)
        end
      end
      
    end
  end # Collection
end # Yogo