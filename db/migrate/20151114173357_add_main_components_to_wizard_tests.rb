class AddMainComponentsToWizardTests < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :main_components, :text
  end
end
