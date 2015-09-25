class AddUrlFragmentToFaqArticles < ActiveRecord::Migration
  def change
    add_column :faq_articles, :url_fragment, :string
  end
end
