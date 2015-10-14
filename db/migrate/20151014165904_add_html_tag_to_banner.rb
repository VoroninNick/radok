class AddHtmlTagToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :title_html_tag, :string
  end
end
