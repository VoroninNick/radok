class Wizard::Platform < ActiveRecord::Base
  attr_accessible *attribute_names
  has_ancestry

  has_and_belongs_to_many :product_types, class_name: Wizard::ProductType, join_table: :wizard_platforms_product_types
  attr_accessible :product_types, :product_type_ids

  has_attached_file :avatar
end
