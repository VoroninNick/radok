class FaqArticle < ActiveRecord::Base
  attr_accessible :published, :name, :content
  has_sitemap_record

  scope :published, -> { where(published: 't') }

  has_seo_tags

  before_save :setup_url_fragment

  validates :name, presence: true

  def setup_url_fragment
    self.url_fragment = self.name.parameterize if self.url_fragment.blank?
  end

  def self.setup_url_for_all
    self.all.each do |item|
      item.setup_url_fragment
      item.save
    end
  end

  def to_param
    url_fragment
  end

  def url
    Rails.application.routes.url_helpers.faq_article_path(id: self.to_param)
  end
end
