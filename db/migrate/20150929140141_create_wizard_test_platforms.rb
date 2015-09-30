class CreateWizardTestPlatforms < ActiveRecord::Migration
  def change
    create_table :wizard_test_platforms, id: false do |t|
      t.integer :platform_id, null: false
      t.integer :test_id, null: false
      t.integer :testers_count

      t.timestamps null: false
    end

    add_index :wizard_test_platforms, [:test_id, :platform_id], unique: true, name: :index_wizard_test_platform_unique_bindings
  end
end
