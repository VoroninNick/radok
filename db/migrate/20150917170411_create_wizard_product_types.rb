class CreateWizardProductTypes < ActiveRecord::Migration
  def change
    create_table :wizard_product_types do |t|
      t.string :name
      t.has_attached_file :image
      t.timestamps null: false
    end
  end
end
