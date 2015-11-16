class AddCommentToWizardTestPlatforms < ActiveRecord::Migration
  def change
    add_column :wizard_test_platforms, :comment, :text
  end
end
