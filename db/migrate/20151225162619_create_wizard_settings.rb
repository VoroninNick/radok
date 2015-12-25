class CreateWizardSettings < ActiveRecord::Migration
  def change
    create_table :wizard_settings do |t|
      t.integer :hour_price
      t.boolean :enable_credit_card_payment_method

      t.timestamps null: false
    end
  end
end
