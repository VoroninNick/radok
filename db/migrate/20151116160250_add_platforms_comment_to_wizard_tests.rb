class AddPlatformsCommentToWizardTests < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :platforms_comment, :text
  end
end
