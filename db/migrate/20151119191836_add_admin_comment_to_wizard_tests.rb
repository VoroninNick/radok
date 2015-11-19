class AddAdminCommentToWizardTests < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :admin_comment, :text
  end
end
