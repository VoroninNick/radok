class CreateWizardTests < ActiveRecord::Migration
  def change
    create_table :wizard_tests do |t|
      t.string :state
      t.float :percent_completed
      t.string :steps_json


      t.timestamps null: false
    end
  end
end
