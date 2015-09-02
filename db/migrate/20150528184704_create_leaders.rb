class CreateLeaders < ActiveRecord::Migration
  def change
    create_table :leaders do |t|
      t.has_attached_file :image
      t.string :name
      t.string :position

      t.timestamps null: false
    end
  end
end
