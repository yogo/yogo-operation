require 'yogo/collection/base'
require 'yogo/collection/data'
require 'yogo/collection/asset'
require 'yogo/collection/static'

module Yogo
  module Collection
    def self.context
      Thread.current[:yogo_collection_contexts] ||= []
    end
  end
end