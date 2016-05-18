# == Schema Information
#
# Table name: contact_feedbacks
#
#  id          :integer          not null, primary key
#  name        :string
#  email       :string
#  subject     :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ContactFeedbackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
