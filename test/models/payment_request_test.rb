# == Schema Information
#
# Table name: payment_requests
#
#  id               :integer          not null, primary key
#  full_name        :string
#  phone            :string
#  description      :string
#  payment_method   :string
#  billing_address  :string
#  city             :string
#  zip_code         :string
#  country          :string
#  card_holder_name :string
#  card_number      :string
#  expire_month     :string
#  expire_year      :string
#  test_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  email            :string
#  payment_id       :string
#  link             :text
#  state            :string
#

require 'test_helper'

class PaymentRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
