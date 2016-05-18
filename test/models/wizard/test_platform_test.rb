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

require 'test_helper'

class Wizard::TestPlatformTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
