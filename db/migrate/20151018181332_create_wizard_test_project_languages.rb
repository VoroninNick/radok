class CreateWizardTestProjectLanguages < ActiveRecord::Migration
  def change
    create_table :wizard_test_project_languages do |t|
      t.integer :test_id, index: true, foreign_key: true
      t.integer :project_language_id, index: true, foreign_key: true
    end
  end
end
