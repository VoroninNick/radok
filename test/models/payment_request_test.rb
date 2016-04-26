# == Schema Information
#
# Table name: payment_requests
#
#  id               :integer          not null, primary key
#  email            :string
#  card_holder_name :string
#  exp_month        :string
#  exp_year         :string
#  test_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  state            :boolean
#  payment_type     :string
#

require 'test_helper'

class PaymentRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
