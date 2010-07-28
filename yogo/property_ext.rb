unless DataMapper::Property.accepted_options.include?(:label)
  DataMapper::Property.accept_options(:label)
end

unless DataMapper::Property.accepted_options.include?(:hidden)
  DataMapper::Property.accept_options(:hidden)
end