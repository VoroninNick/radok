# == Schema Information
#
# Table name: wizard_platforms
#
#  id                  :integer          not null, primary key
#  name                :string
#  testers_count       :integer
#  ancestry            :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  position            :integer
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

require 'test_helper'

class Wizard::PlatformTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
