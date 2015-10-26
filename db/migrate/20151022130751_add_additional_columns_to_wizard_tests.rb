class AddAdditionalColumnsToWizardTests < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :expected_tested_at, :datetime
  end
end
