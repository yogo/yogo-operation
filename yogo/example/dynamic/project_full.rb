require 'yogo/configuration'
require 'yogo/datamapper/model/configuration'
require 'yogo/datamapper/model/common/properties'
require 'dm-types/yaml'

DataMapper.setup(:default, :adapter => 'sqlite3', :database => 'dynamic_project.db')

class ProjectFull
  include DataMapper::Resource
  
  Yogo::DataMapper::Model::Common::Properties::UUIDKey[self]
  
  property :name,             String,     :required => true
  
  has n, :managed_models
end


class ManagedModel
  include DataMapper::Resource
  include Yogo::DataMapper::Model::Configuration
  
  Yogo::DataMapper::Model::Common::Properties::UUIDKey[self]
  property :name,             String,     :required => true
  
  has n, :model_operations
  
  def operation_definitions
    model_operations.map{|model_op| model_op.to_a }
  end
  
  def update(model=nil)
    to_proc.call(model || (@_model ||= DataMapper::Model.new))
  end
end

class ModelOperation
  include DataMapper::Resource
  
  Yogo::DataMapper::Model::Common::Properties::UUIDKey[self]
  
  property :operation,        String,     :required => true
  property :parameters,       Yaml,       :default => lambda{|*args| [] }
  
  def to_a
    [self.operation, self.parameters].flatten
  end
end