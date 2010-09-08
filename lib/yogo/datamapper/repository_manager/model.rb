module Yogo
  module DataMapper
    module RepositoryManager
      module Model
        # Class method for informing Project instances about what kinds of models
        # might be stored inside thier Project#managed_repository.
        #
        # @param [DataMapper::Model] model class that might be stored in Project managed_repositories
        # @return [Array<DataMapper::Model>] list of currently managed models
        def manage(*args)
          @managed_models ||= []
          models = args

          @managed_models += models
          @managed_models.uniq!

          @managed_models
        end
        
        # Models that are currently managed by Project instances.
        # @return [Array<DataMapper::Model>] list of currently managed models
        def managed_models
          @managed_models
        end
        
        # Ensure that Relation models are also managed
        def finalize_managed_models!
          models = []
          @managed_models.each do |m|
            models += m.relationships.values.map{|r| r.child_model }
            models += m.relationships.values.map{|r| r.parent_model }
          end
          @managed_models += models
          @managed_models.uniq!
          @managed_models
        end
      end # Model
    end # RepositoryManager
  end # DataMapper
end # Yogo