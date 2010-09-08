require 'yogo/support/extension_module'
require 'yogo/operation/concurrent/call'

module Yogo
  module Operation
    module Concurrent
      extend Yogo::ExtensionModule
      
      instance_extensions do
        extend Concurrent::Call
      end
      
      class_extensions do
        include Concurrent::Call
      end
    end # Concurrent
  end # Operation
end # Yogo