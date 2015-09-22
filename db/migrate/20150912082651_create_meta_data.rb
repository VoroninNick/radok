class CreateMetaData < ActiveRecord::Migration
  def change
    create_table :meta_data do |t|
      t.string :page_type
      t.integer :page_id
      t.string :head_title
      t.text :keywords
      t.text :description

      t.timestamps null: false
    end
  end
end
