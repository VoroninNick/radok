class Page < ActiveRecord::Base
  attr_accessible *attribute_names
  has_seo_tags
  has_banner

  def self.default_url
    self.name.split("::").last.underscore.humanize.parameterize
  end

  def self.default_head_title
    self.name.split("::").last.underscore.humanize
  end

  def self.disabled
    false
  end
end
