require 'yogo/support/proc'
require 'yogo/operation/base'
require 'yogo/operation/restricted'
require 'yogo/operation/closed'
require 'yogo/operation/concurrent'

module Yogo
  class Op < Proc
    extend Yogo::Operation::Base
    extend Yogo::Operation::Restricted
    extend Yogo::Operation::Closed
  end # Op
  
  class FlowOp < Op
    extend Yogo::Operation::Concurrent
  end
end # Yogo