class AddTotalPriceToWizardTests < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :total_price, :integer
  end
end
