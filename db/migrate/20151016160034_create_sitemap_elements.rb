class CreateSitemapElements < ActiveRecord::Migration
  def up
    create_table :sitemap_elements do |t|
      t.string :page_type
      t.integer :page_id

      t.boolean :display_on_sitemap
      t.string :changefreq
      t.float :priority

      t.timestamps null: false
    end
  end

  def down
    drop_table :sitemap_elements
  end
end
