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

class PaymentRequest < ActiveRecord::Base
  attr_accessible *attribute_names
  belongs_to :test, class: Wizard::Test
  attr_accessible :test

  def self.default_payment_type
    'paypal'
  end

  def self.default_payment_type_paypal?
    default_payment_type == 'paypal'
  end

  def to_builder
    Jbuilder.new do |t|
      t.full_name full_name
      t.phone phone
      t.email email
      t.description description
      t.payment_method payment_method
      t.payment_id payment_id
      t.billing_address billing_address
      t.city city
      t.zip_code zip_code
      t.country country
      t.card_holder_name card_holder_name
      t.card_number card_number
      t.expire_month expire_month
      t.expire_year expire_year
      t.test_id test_id
      t.link link
      t.state state
    end
  end

  def pay_later?
    self.payment_type == 'pay_later'
  end
end
