class AddBillingAddressAndPaymentType < ActiveRecord::Migration
  def change
    add_column :users, :billing_address, :text
    add_column :payment_requests, :payment_type, :string
  end
end
