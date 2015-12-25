class CreateWizardTexts < ActiveRecord::Migration
  def change
    create_table :wizard_texts do |t|
      t.text :json_data
      t.timestamps null: false
    end
  end
end
