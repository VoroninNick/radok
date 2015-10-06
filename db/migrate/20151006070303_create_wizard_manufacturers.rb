class CreateWizardManufacturers < ActiveRecord::Migration
  def change
    create_table :wizard_manufacturers do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
