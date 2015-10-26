class CreateHtmlBlocks < ActiveRecord::Migration
  def up
    create_table :html_blocks do |t|
      t.text :content

      t.integer :attachable_id
      t.string :attachable_type
      t.string :attachable_field_name
      t.string :key

    end


    HtmlBlock.create_translation_table!(content: :text) if HtmlBlock.respond_to?(:translates?) && HtmlBlock.translates?
  end

  def down
    HtmlBlock.drop_translation_table! if HtmlBlock.respond_to?(:translates?) && HtmlBlock.translates?

    drop_table :html_blocks
  end
end
