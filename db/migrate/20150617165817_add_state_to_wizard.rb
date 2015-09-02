class AddStateToWizard < ActiveRecord::Migration
  def change
    add_column :simple_wizard_tests, :state, :text
  end
end
