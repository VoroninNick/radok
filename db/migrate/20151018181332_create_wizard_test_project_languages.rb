class CreateWizardTestProjectLanguages < ActiveRecord::Migration
  def change
    create_table :wizard_test_project_languages do |t|
      t.belongs_to :test, index: true, foreign_key: true
      t.belongs_to :project_language, index: true, foreign_key: true
    end
  end
end
