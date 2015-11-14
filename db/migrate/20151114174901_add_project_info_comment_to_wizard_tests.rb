class AddProjectInfoCommentToWizardTests < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :project_info_comment, :text
  end
end
