class FaqArticle < ActiveRecord::Base
  attr_accessible :published, :name, :content

  scope :published, -> { where(published: 't') }
end
