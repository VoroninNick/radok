# == Schema Information
#
# Table name: wizard_devices
#
#  id                  :integer          not null, primary key
#  manufacturer_id     :integer
#  model               :string
#  os                  :string
#  screen_pixel_width  :integer
#  screen_pixel_height :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class Wizard::DeviceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
