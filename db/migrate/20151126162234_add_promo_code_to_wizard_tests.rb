class AddPromoCodeToWizardTests < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :promo_code_id, :integer, index: true, foreign_key: true
  end
end
