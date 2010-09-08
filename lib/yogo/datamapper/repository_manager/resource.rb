module Yogo
  module DataMapper
    module RepositoryManager
      module Resource        
        def managed_repository_name
          raise NotImplementedError
        end

        def adapter_config
          raise NotImplementedError
        end

        def adapter
          begin
            ::DataMapper.repository(managed_repository_name).adapter
          rescue ::DataMapper::RepositoryNotSetupError
            ::DataMapper.setup(managed_repository_name, adapter_config)
            retry
          end
        end

        def managed_repository(&block)
          adapter # ensure the adapter get's setup or exists
          if block_given?
            ::DataMapper.repository(managed_repository_name, &block)
          else
            ::DataMapper.repository(managed_repository_name)
          end
        end
        
        # Ensure that models that models managed by the Project
        # are properly migrated/upgraded inside the Project managed repository.
        #
        # @author Ryan Heimbuch
        # @todo Refactor this method into a module in yogo-project
        def prepare_models
          adapter # ensure the adapter exists or is setup
          managed_repository.scope {
            self.class.finalize_managed_models!
            self.class.managed_models.each do |klass|
              klass.auto_upgrade!
            end
          }
        end
        
        # Ensure that models that we might store in the Project#managed_repository
        # are properly migrated/upgrade whenever the Project changes.
        # @author Ryan Heimbuch
        # @see Project#prepare_models
        after :save, :prepare_models
        
        # Builds a "new", unsaved datamapper resource, that is explicitly
        # bound to the Project#managed_repository.
        # If you want to create a new resource that will be saved inside the
        # repository of a Project, you should always use this method.
        #
        # @example Create a new site that is stored in myProject.managed_repository
        #   managedSite = myProject.build_managed(Voeis::Site, :name => ...)
        #
        # @example Doing any of these will NOT work consistently (if at all)
        #   managedSite1 = Voeis::Site.new(:name => ...)
        #   managedSite1.save # WILL NOT save in myProject.managed_repository
        #
        #   managedSite2 = myProject.managed_repository{Voeis::Site.new(:name => ...)}
        #   managedSite2.save # WILL NOT save in myProject.managed_repository
        #
        # Boring Details:
        #   Initially "new" model resources do not bind themselves to any repository.
        #   At some point a "new" resource will persist itself and bind itself exclusively
        #   to the repository that it "persisted into". This step is fiddly to catch, and
        #   happens deep inside the DataMapper code. It is MUCH easier to explictly bind
        #   the "new" resource to a particular repository immediately after calling #new.
        #   This requires using reflection to modify the internal state of the resource object,
        #   so it is best sealed inside a single method, rather than scattered throughout
        #   the codebase.
        #
        # @todo Refactor into module in yogo-project
        # @author Ryan Heimbuch
        def build_managed(model_klass, attributes={})
          unless self.class.managed_models.include? model_klass
            self.class.manage(model_klass)
            prepare_models
          end
          res = model_klass.new(attributes)
          res.instance_variable_set(:@_repository, managed_repository)
          res
        end
      end # RepositoryModels
    end # RepositoryManager
  end # DataMapper
end # Yogo