class FaqArticle < ActiveRecord::Base
  attr_accessible :published, :name, :content

  scope :published, -> { where(published: 't') }

  has_seo_tags
end
