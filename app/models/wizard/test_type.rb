class Wizard::TestType < ActiveRecord::Base
  self.table_name = :wizard_test_types

  attr_accessible *attribute_names

  has_attached_file :image
  attr_accessible :image

  do_not_validate_attachment_file_type :image

end
