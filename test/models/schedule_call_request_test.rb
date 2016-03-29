# == Schema Information
#
# Table name: schedule_call_requests
#
#  id          :integer          not null, primary key
#  phone       :string
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ScheduleCallRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
