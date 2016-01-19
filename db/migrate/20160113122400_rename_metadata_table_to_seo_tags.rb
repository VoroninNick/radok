class RenameMetadataTableToSeoTags < ActiveRecord::Migration
  def change
    rename_table :meta_data, :seo_tags
  end
end
