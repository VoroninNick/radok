class CreateContactRequests < ActiveRecord::Migration
  def change
    create_table :contact_requests do |t|
      t.string :subject
      t.string :name
      t.string :email
      t.text :description

      t.timestamps null: false
    end
  end
end
