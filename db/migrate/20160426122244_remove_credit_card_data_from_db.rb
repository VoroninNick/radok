# Remove storing payment data from DB
#
class RemoveCreditCardDataFromDb < ActiveRecord::Migration
  def change
    change_table :payment_requests do |t|
      t.remove :card_number
      t.remove :cvv_number
      t.remove :full_name
      t.remove :phone
      t.remove :comment
      t.remove :payment_type
      t.remove :city
      t.remove :zip_code
      t.remove :country
    end

    add_column :payment_requests, :state, :boolean

    change_table :users do |t|
      t.remove :billing_cardholder_name
      t.remove :billing_address
      t.remove :billing_card_number
      t.remove :billing_cvv_number
    end
  end
end
