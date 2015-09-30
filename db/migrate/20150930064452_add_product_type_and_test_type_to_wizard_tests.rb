class AddProductTypeAndTestTypeToWizardTests < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :product_type_id, :integer
    add_column :wizard_tests, :test_type_id, :integer
  end
end
