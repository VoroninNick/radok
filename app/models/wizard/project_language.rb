# == Schema Information
#
# Table name: wizard_project_languages
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Wizard::ProjectLanguage < ActiveRecord::Base
  attr_accessible *attribute_names

  has_and_belongs_to_many :projects, class_name: Wizard::Test, join_table: :wizard_test_project_languages
  attr_accessible :projects

  validates :name, uniqueness: true

end
