class AddUserIdToWizardTests < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :user_id, :integer
  end
end
