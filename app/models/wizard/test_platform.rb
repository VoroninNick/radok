# == Schema Information
#
# Table name: wizard_test_platforms
#
#  platform_id   :integer          not null, primary key
#  test_id       :integer          not null, primary key
#  testers_count :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  comment       :text
#

class Wizard::TestPlatform < ActiveRecord::Base
  self.primary_keys = [:test_id, :platform_id]

  belongs_to :test, class_name: Wizard::Test
  belongs_to :platform, class_name: Wizard::Platform

  attr_accessible *attribute_names
end
