require 'yogo/support/extension_module'
require 'yogo/support/proc/call'
require 'yogo/support/proc/partial'
require 'yogo/support/proc/compose'

module Yogo
  module Operation
    module Base
      extend Yogo::ExtensionModule
      
      instance_extensions do
        extend Support::Proc::Call
        extend Support::Proc::Partial
        extend Support::Proc::Compose
      end
      
      class_extensions do
        include Support::Proc::Call
        include Support::Proc::Partial
        include Support::Proc::Compose
      end
    end # Base
  end # Operation
end # Yogo