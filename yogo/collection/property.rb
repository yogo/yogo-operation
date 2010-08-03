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
      
      validates_uniqueness_of :name, :scope => :data_collection_id
      
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
      
      COMMON_PROPERTIES = [:String, :Text, :Integer, :Float, :Boolean, :Date, :Time, :DateTime]
      COMMON_PROPERTIES.each do |type|
        class_eval %{
        class #{type} < Property; end
        }
      end
    end # Property
    
    
    class Relationship < Property
      property    :target_collection_id, UUID
      belongs_to  :target_collection, :model => 'Yogo::Collection::Data'
      
      def target_model
        target_collection.data_model
      end
      
      def model_method
        :has
      end
      
      def check_target
        raise ":target not set" unless self.target && !self.target.empty?
      end
      
      def add_to_model(model, n, options={})
        check_target
        model.send(model_method, n, ActiveSupport::Inflector.tableize(self.target).intern, options.merge(self.options))
      end
      
      class ManyToMany < self
        def add_to_model(model)
          super(model, Infinity, :through => DataMapper::Resource)
        end
      end
      
      class OneToMany < self
        def add_to_model(model)
          super(model)
        end
      end
      
      class OneToOne < self
        def add_to_model(model)
          super(model, 1)
        end
      end
      
      class ManyToOne < self
        def model_method
          :belongs_to
        end
        
        def add_to_model(model)
          check_target
          model.send(model_method, ActiveSupport::Inflector.underscore(self.target).intern, options.merge(self.options))
        end
      end
      
    end
  end # Collection
end # Yogo