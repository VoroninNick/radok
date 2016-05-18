# == Schema Information
#
# Table name: wizard_test_types
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

class Wizard::TestType < ActiveRecord::Base
  self.table_name = :wizard_test_types

  attr_accessible *attribute_names

  has_attached_file :image
  attr_accessible :image

  do_not_validate_attachment_file_type :image

  has_many :tests, class_name: Wizard::Test

  validates :name, uniqueness: true

  def usability_test?
    self.name.downcase == "usability"
  end

  def functional_test?
    self.name.downcase == "functional"
  end

  def localization_test?
    self.name.downcase == "localization"
  end

end
