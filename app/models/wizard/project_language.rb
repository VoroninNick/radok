class Wizard::ProjectLanguage < ActiveRecord::Base
  attr_accessible *attribute_names

  has_and_belongs_to_many :projects, class_name: Wizard::Test, join_table: :wizard_test_project_languages
  attr_accessible :projects

end
