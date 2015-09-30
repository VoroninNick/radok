class Wizard::TestPlatform < ActiveRecord::Base
  self.primary_keys = [:test_id, :platform_id]

  belongs_to :test, class_name: Wizard::Test
  belongs_to :platform, class_name: Wizard::Platform

  attr_accessible *attribute_names
end
