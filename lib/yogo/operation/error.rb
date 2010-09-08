require 'ostruct'
require 'forwardable'

module Yogo
  module Operation
    class OperationError < StandardError
      attr_reader :information
      
      extend Forwardable
      def_delegators :information, :operation, :action
      
      def initialize(options={})
        message = options.delete(:message)
        @information = OpenStruct.new(options)
        @information.freeze
        
        message ? super(message) : super()
      end
      
      
    end # OperationError
  end # Operation
end # Yogo