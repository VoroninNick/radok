class AddProceededStepsCountWizardSteps < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :proceeded_steps_count, :integer
  end
end
