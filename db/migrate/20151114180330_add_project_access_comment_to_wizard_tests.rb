class AddProjectAccessCommentToWizardTests < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :project_access_comment, :text
  end
end
