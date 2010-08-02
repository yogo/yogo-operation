
require 'yogo/configuration'

module Yogo
  module Collection
    class Asset

      module ModelProperties
        def self.extended(model)
          uploader = Class.new(CarrierWave::Uploader::Base)
          uploader.storage(:file)
          uploader.class_eval %{
            def store_dir
              File.join('#{Configuration.collection.asset.storage_dir}', '#{model.collection.collection_storage_name}')
            end
          }, __FILE__, __LINE__+1
          
          model.class_eval do
            without_auto_validations do
              property :content_type, String
              property :description,  String
              property :asset_file,   String
            end
            
            validates_uniqueness_of :asset_file
            
            mount_uploader :file, uploader, :mount_on => :asset_file
            after :file=, :write_file_identifier
          end
        end
      end # ModelProperties
    end # Base
  end # Collection
end # Yogo