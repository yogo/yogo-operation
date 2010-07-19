require 'yogo/project/collection/data/definition'

module Yogo
  class Project
    class Collection
      module Data
        module Model
          def self.included(base)
            base.extend(ClassMethods)
            base.extend(Data::Definition)
          end
                
          module ClassMethods
            def default_repository_name
              self.project_collection.data_repository.name
            end
            
            def default_storage_name
              self.project_collection.data_storage_name
            end
        
            def project_collection
              @_project_collection
            end
        
            def project_collection=(col)
              @_project_collection=col
            end
            
          end # ClassMethods
        end # Model
      end # Data
    end # Collection
  end # Project
end # Yogo