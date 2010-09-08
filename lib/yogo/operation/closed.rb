require 'yogo/support/extension_module'
require 'yogo/operation/closed/call'

module Yogo
  module Operation
    module Closed
      extend Yogo::ExtensionModule
      
      instance_extensions do
        extend Closed::Call
      end
      
      class_extensions do
        include Closed::Call
      end
    end # Closed
  end # Operation
end # Yogo