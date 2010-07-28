require 'dm-core'
require 'dm-validations'
require 'dm-types'
require 'yogo/property_ext'
require 'yogo/collection'

module Yogo
  class Project
    include DataMapper::Resource
    
    property :id,           Serial
    property :name,         String,   :required => true
    property :description,  Text,     :required => false
    
    validates_uniqueness_of :name
    
    remix n, :collections
    
    enhance :collections do
      remix n, :schemas
      remix n, :forms
    end
    
    
      
  end
end # Yogo