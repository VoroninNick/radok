class CreateWizardPlatformsProductTypes < ActiveRecord::Migration
  def change
    create_table :wizard_platforms_product_types, id: false do |t|
      t.integer :platform_id
      t.integer :product_type_id
    end

    add_index :wizard_platforms_product_types, [:platform_id, :product_type_id], unique: true, name: :index_unique_platforms_product_types
  end
end
