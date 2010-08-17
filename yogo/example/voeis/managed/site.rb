# Sites TODO- validate the best practices below
#
# This is a "Monitoring Site Locations"
# The Sites table provides information giving the spatial location at which data values have been
# collected.
# The following rules and best practices should be followed when populating this table:
# * The SiteID field is the primary key, must be a unique integer, and cannot be NULL.  This
# field should be implemented as an auto number/identity field.
# * The SiteCode field must contain a text code that uniquely identifies each site.  The values
# in this field should be unique and can be an alternate key for the table.  SiteCodes cannot
# contain any characters other than A-Z (case insensitive), 0-9, period “.”, dash “-“, and
# underscore “_”.
# * The LatLongDatumID must reference a valid SpatialReferenceID from the
# SpatialReferences controlled vocabulary table.  If the datum is unknown, a default value
# of 0 is used.
# * If the Elevation_m field is populated with a numeric value, a value must be specified in
# the VerticalDatum field.  The VerticalDatum field can only be populated using terms
# from the VerticalDatumCV table.  If the vertical datum is unknown, a value of
# “Unknown” is used.
# * If the LocalX and LocalY fields are populated with numeric values, a value must be
# specified in the LocalProjectionID field.  The LocalProjectionID must reference a valid
# SpatialReferenceID from the SpatialReferences controlled vocabulary table.  If the spatial
# reference system of the local coordinates is unknown, a default value of 0 is used.
#
module Yogo
  module Voeis
    module Managed
      class Site
        include ::DataMapper::Resource
        
        property :id,               UUID,       :key => true, :default => lambda { UUIDTools::UUID.timestamp_create }
        property :site_code, String, :required => true
        property :site_name, String, :required => true
        property :latitude, Float, :required => true
        property :longitude, Float, :required => true
        property :lat_long_datum_id, Integer, :required => true, :default => 0
        property :elevation_m, Float, :required => false
        property :vertical_datum, String, :required => false
        property :local_x, Float,  :required => false
        property :local_y, Float, :required => false
        property :local_projection_id, Integer, :required => false
        property :pos_accuracy_m, Float, :required => false
        property :state, String, :required => false
        property :country, String, :required => false
        property :comments, String, :required => false
      
        has n,     :data_streams, :through => Resource
      end # Site
    end # Managed
  end # Voeis
end # Yogo