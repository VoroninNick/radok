class AddPromoCodeToWizardTests < ActiveRecord::Migration
  def change
    add_reference :wizard_tests, :promo_code, index: true, foreign_key: true
  end
end
