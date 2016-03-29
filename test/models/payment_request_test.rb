# == Schema Information
#
# Table name: payment_requests
#
#  id               :integer          not null, primary key
#  full_name        :string
#  phone            :string
#  email            :string
#  comment          :string
#  payment_type     :string
#  billing_address  :string
#  city             :string
#  zip_code         :string
#  country          :string
#  card_holder_name :string
#  card_number      :string
#  exp_month        :string
#  exp_year         :string
#  cvv_number       :string
#  test_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class PaymentRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
