class CreatePaymentRequests < ActiveRecord::Migration
  def change
    create_table :payment_requests do |t|
      t.string :full_name
      t.string :phone
      t.string :email
      t.string :comment
      t.string :payment_type
      t.string :billing_address
      t.string :city
      t.string :zip_code
      t.string :country
      t.string :card_holder_name
      t.string :card_number
      t.string :exp_month
      t.string :exp_year
      t.string :cvv_number
      t.belongs_to :test

      t.timestamps null: false
    end
  end
end
