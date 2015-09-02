class CreateWizardPlatforms < ActiveRecord::Migration
  def change
    create_table :wizard_platforms do |t|
      t.string :name
      t.integer :testers_count
      t.string :ancestry

      t.timestamps null: false
    end
  end
end
