module Yogo
  module Collection
    class Asset
      module Model
        def to_s
          "AssetItemModel[#{default_storage_name}]"
        end
      end # Model
    end # Asset
  end # Collection
end # Yogo