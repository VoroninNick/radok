# == Schema Information
#
# Table name: contact_requests
#
#  id          :integer          not null, primary key
#  subject     :string
#  name        :string
#  email       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ContactRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
