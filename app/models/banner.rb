class Banner < ActiveRecord::Base
  attr_accessible *attribute_names

  has_attached_file :background_image
  attr_accessible :background_image

  do_not_validate_attachment_file_type :background_image

  before_save :set_default_title_html_tag

  def set_default_title_html_tag
    self.title_html_tag = "div" if self.title_html_tag.blank?
    try
  end
end
