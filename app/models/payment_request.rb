class PaymentRequest < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :test, class: Wizard::Test
  attr_accessible :test

  def self.default_payment_type
    "visa_and_master_card"
  end

  def to_builder
    Jbuilder.new do |t|
      t.full_name full_name
      t.phone phone
      t.email email
      t.comment comment
      t.payment_type payment_type
      t.billing_address billing_address
      t.city city
      t.zip_code zip_code
      t.country country
      t.card_holder_name card_holder_name
      t.card_number card_number
      t.exp_month exp_month
      t.exp_year exp_year
      t.cvv_number cvv_number
      t.test_id test_id
    end
  end

  def pay_later?
    self.payment_type == "pay_later"
  end
end
