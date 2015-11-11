class AddActiveStepIdToWizardTests < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :current_step_id, :integer
  end
end
