class AddEnablePaypalPaymentMethodToWizardSettings < ActiveRecord::Migration
  def change
    add_column :wizard_settings, :enable_paypal_payment_method, :boolean
  end
end
