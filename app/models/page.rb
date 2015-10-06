class Page < ActiveRecord::Base
  attr_accessible *attribute_names
  has_seo_tags
  has_banner

  after_save :reload_routes, if: proc { self.url_changed? }

  def self.default_url
    self.name.split("::").last.underscore.humanize.parameterize
  end

  def self.default_head_title
    self.name.split("::").last.underscore.humanize
  end

  def self.disabled
    false
  end


  def reload_routes
    DynamicRouter.reload

  end

  # def store_if_url_changed
  #
  # end
  #
  # def check_if_url_changed?
  #   return self.url_changed?
  # end
end
