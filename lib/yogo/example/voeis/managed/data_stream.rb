# Yogo Data Management Toolkit
# Copyright (c) 2010 Montana State University
#
# License -> see license.txt
#
# FILE: data_stream.rb
# The Data Stream model is where the streaming data parsing templates are stores.
#

# Class for a Yogo Project. A project contains a name, a description, and access to all of the models
# that are part of the project.
module Yogo
  module Voeis
    module Managed
      class DataStream
        include ::DataMapper::Resource

        property :id,   UUID,       :key => true, :default => lambda { UUIDTools::UUID.timestamp_create }

        property :name, String, :required => true, :unique => true
        property :description, Text, :required => false
        property :filename, String, :required => true, :length => 512
        property :start_line, Integer, :required => true, :default => 0

        property :project_id, Integer, :required =>true, :default => 1

        validates_uniqueness_of   :name

        #before :destroy, :delete_data_stream_columns!
        
        has n, :sites, :through => Resource
        # has n, :data_stream_columns, :model => "DataStreamColumn", :through => Resource



      end # DataStream
    end # Managed
  end # Voeis
end # Yogo