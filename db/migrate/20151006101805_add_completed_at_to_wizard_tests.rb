class AddCompletedAtToWizardTests < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :completed_at, :datetime
  end
end
