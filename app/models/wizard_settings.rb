class WizardSettings < ActiveRecord::Base
  self.table_name = :wizard_settings
  attr_accessible *attribute_names

  def self.hour_price
    WizardSettings.first.try(&:hour_price) || 1
  end

  def self.enabled_credit_card_payment_method?
    res = WizardSettings.first.try(&:enable_credit_card_payment_method)
    res ||= false

    res
  end
end
