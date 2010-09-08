require 'configatron'

module Yogo
  Configuration = Configatron::Store.new
  Configuration.random_uuid = Configatron::Dynamic.new { UUIDTools::UUID.timestamp_create }
  Configuration.collection.set_default(:data_repository_name, :collection_data)
  Configuration.collection.asset.set_default(:storage_dir, 'asset_collection')
end
    