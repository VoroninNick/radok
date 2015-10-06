class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.belongs_to :page
      t.string :title
      t.string :description
      t.has_attached_file :background_image
      t.string :button_label
      t.string :button_url

      t.timestamps null: false
    end
  end
end
