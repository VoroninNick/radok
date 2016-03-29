# == Schema Information
#
# Table name: wizard_settings
#
#  id                                :integer          not null, primary key
#  hour_price                        :integer
#  enable_credit_card_payment_method :boolean
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  enable_paypal_payment_method      :boolean
#

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

  def self.enabled_paypal_payment_method?
    res = WizardSettings.first.try(&:enable_paypal_payment_method)
    res ||= false

    res
  end

  def self.enabled_any_payment_method?
    enabled_credit_card_payment_method? || enabled_paypal_payment_method?
  end
end
