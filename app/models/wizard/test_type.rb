class Wizard::TestType < ActiveRecord::Base
  self.table_name = :wizard_test_types

  attr_accessible *attribute_names

  has_attached_file :image
  attr_accessible :image

  do_not_validate_attachment_file_type :image

  has_many :tests, class_name: Wizard::Test

  validates :name, uniqueness: true

end
