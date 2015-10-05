class AddActiveStepNumberToWizardTests < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :active_step_number, :integer
  end
end
