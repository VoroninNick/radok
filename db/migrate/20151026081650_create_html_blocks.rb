class CreateHtmlBlocks < ActiveRecord::Migration
  def up
    create_table :html_blocks do |t|
      t.text :content

      t.integer :attachable_id
      t.string :attachable_type
      t.string :attachable_field_name
      t.string :key

    end


    Cms::HtmlBlock.create_translation_table!(content: :text) if Cms::HtmlBlock.respond_to?(:translates?) && Cms::HtmlBlock.translates?
  end

  def down
    Cms::HtmlBlock.drop_translation_table! if Cms::HtmlBlock.respond_to?(:translates?) && Cms::HtmlBlock.translates?

    drop_table :html_blocks
  end
end
