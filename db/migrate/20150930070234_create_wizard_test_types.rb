class CreateWizardTestTypes < ActiveRecord::Migration
  def change
    create_table :wizard_test_types do |t|
      t.string :name
      t.has_attached_file :image

      t.timestamps null: false
    end
  end
end
