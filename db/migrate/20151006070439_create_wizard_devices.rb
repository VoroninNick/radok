class CreateWizardDevices < ActiveRecord::Migration
  def change
    create_table :wizard_devices do |t|
      t.belongs_to :manufacturer, index: true, foreign_key: true
      t.string :model
      t.string :os
      t.integer :screen_pixel_width
      t.integer :screen_pixel_height

      t.timestamps null: false
    end
  end
end
