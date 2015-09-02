class CreateFaqArticles < ActiveRecord::Migration
  def change
    create_table :faq_articles do |t|
      t.boolean :published
      t.string :name
      t.text :content
      t.timestamps null: false
    end
  end
end
