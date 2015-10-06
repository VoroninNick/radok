class AddTestedAtToWizardTests < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :tested_at, :datetime
  end
end
