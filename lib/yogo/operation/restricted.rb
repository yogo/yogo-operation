require 'yogo/support/extension_module'
require 'yogo/operation/restricted/construction'
require 'yogo/operation/restricted/call'
require 'yogo/operation/restricted/partial'

module Yogo
  module Operation
    module Restricted
      extend Yogo::ExtensionModule
      
      instance_extensions do
        extend Restricted::Call
        extend Restricted::Partial
      end
      
      class_extensions do
        extend Restricted::Construction
        include Restricted::Call
        include Restricted::Partial
      end
    end # Restricted
  end # Operation
end # Yogo