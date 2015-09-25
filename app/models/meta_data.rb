class MetaData < ActiveRecord::Base
  self.table_name = :meta_data

  attr_accessible *attribute_names

  belongs_to :page, polymorphic: true
end
