class CreateWizardProjectLanguages < ActiveRecord::Migration
  def change
    create_table :wizard_project_languages do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
