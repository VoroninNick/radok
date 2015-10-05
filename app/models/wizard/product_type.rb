class Wizard::ProductType < ActiveRecord::Base
  self.table_name = :wizard_product_types

  attr_accessible *attribute_names

  has_attached_file :image
  attr_accessible :image

  do_not_validate_attachment_file_type :image

  has_and_belongs_to_many :platforms, class_name: Wizard::Platform, join_table: :wizard_platforms_product_types
  attr_accessible :platforms, :platform_ids

  has_many :tests, class_name: Wizard::Test


end
