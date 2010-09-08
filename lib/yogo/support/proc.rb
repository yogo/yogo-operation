require 'yogo/support/proc/call'
require 'yogo/support/proc/partial'
require 'yogo/support/proc/compose'

module Yogo
  module Support
    
    class ::Proc
      include Proc::Call
      include Proc::Partial
      include Proc::Compose
    end # ::Proc
    
  end # Support
end # Yogo