class CreateFormConfigs < ActiveRecord::Migration
  def change
    create_table :form_configs do |t|
      t.string :type
      t.text :email_receivers

      t.timestamps null: false
    end
  end
end
