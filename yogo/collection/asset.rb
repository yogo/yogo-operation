require 'yogo/collection/data'
require 'carrierwave'
require 'carrierwave/orm/datamapper'

module Yogo
  module Collection
    class Asset < Data
      require 'yogo/collection/asset/model_configuration'
      include Asset::ModelConfiguration
    end # Asset
  end # Collection
end # Yogo