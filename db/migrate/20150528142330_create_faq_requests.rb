class CreateFaqRequests < ActiveRecord::Migration
  def change
    create_table :faq_requests do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :description

      t.timestamps null: false
    end
  end
end
