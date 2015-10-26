class RemoveLanguagesFromProjects < ActiveRecord::Migration
  def change
    remove_column :wizard_tests, :project_languages, :string
    remove_column :wizard_tests, :report_languages, :string
  end
end
