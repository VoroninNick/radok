class MetaData < ActiveRecord::Base
  self.table_name = :meta_data

  attr_accessible *attribute_names
end
