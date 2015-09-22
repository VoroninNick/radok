class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :type
      t.string :name
      t.text :content
      t.string :url

      t.timestamps null: false
    end
  end
end
