# == Schema Information
#
# Table name: wizard_product_types
#
#  id                 :integer          not null, primary key
#  name               :string
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Wizard::ProductType < ActiveRecord::Base
  self.table_name = :wizard_product_types

  attr_accessible *attribute_names

  has_attached_file :image
  attr_accessible :image

  do_not_validate_attachment_file_type :image

  has_and_belongs_to_many :platforms, class_name: Wizard::Platform, join_table: :wizard_platforms_product_types
  attr_accessible :platforms, :platform_ids

  has_many :tests, class_name: Wizard::Test

  validates :name, uniqueness: true



  def self.platform_ids_by_product_type
    Hash[Wizard::ProductType.all.map{|product_type|  [ product_type.name,  product_type.platforms.pluck(:id) ]  }]
  end
end
