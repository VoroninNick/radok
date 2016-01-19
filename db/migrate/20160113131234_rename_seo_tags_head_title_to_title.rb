class RenameSeoTagsHeadTitleToTitle < ActiveRecord::Migration
  def change
    rename_column :seo_tags, :head_title, :title
  end
end
