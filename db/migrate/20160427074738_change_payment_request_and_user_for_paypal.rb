class ChangePaymentRequestAndUserForPaypal < ActiveRecord::Migration
  def up
    add_column :payment_requests, :payment_id, :string
    add_column :payment_requests, :link, :text
    add_column :payment_requests, :state, :string
    add_column :wizard_tests, :paid_at, :date
    remove_column :payment_requests, :cvv_number
    rename_column :payment_requests, :exp_month, :expire_month
    rename_column :payment_requests, :exp_year, :expire_year
    rename_column :payment_requests, :comment, :description
    rename_column :payment_requests, :payment_type, :payment_method
  end

  def down
    remove_column :payment_requests, :payment_id
    remove_column :payment_requests, :link
    remove_column :payment_requests, :state
    remove_column :wizard_tests, :paid_at
    add_column :payment_requests, :cvv_number, :string
    rename_column :payment_requests, :expire_month, :exp_month
    rename_column :payment_requests, :expire_year, :exp_year
    rename_column :payment_requests, :description, :comment
    rename_column :payment_requests, :payment_method, :payment_type
  end
end
