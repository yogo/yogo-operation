require 'yogo/datamapper/model/operations/clear'
require 'yogo/datamapper/model/operations/add'

module Yogo
  module DataMapper
    module Model
      module Configuration
        
        def operation_definitions
          @_operation_definitions ||= []
        end
        
        def operation(op_name, *args)
          op_def = [op_name.to_s, args].flatten
          operation_definitions << op_def unless operation_definitions.include?(op_def)
        end
        
        def to_proc
          ops = operation_definitions.map{|op_def| Operations[op_def.first] }
          partial_ops = []
          ops.each_with_index do |op, i|
            next unless op
            partial_ops[i] = op.partial(X, *operation_definitions[i][1..-1])
          end
          partial_ops.compact!
          partial_ops.reduce{|composed, partial_op| composed * partial_op}
        end
      end # Configuration
    end # Model
  end # DataMapper
end # Yogo