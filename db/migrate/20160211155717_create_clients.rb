class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.attachment :logo
      t.integer :sorting_position
      t.string :client_url

      t.timestamps null: false
    end
  end
end
