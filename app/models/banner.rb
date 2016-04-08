# == Schema Information
#
# Table name: banners
#
#  id                            :integer          not null, primary key
#  page_id                       :integer
#  title                         :string
#  description                   :string
#  background_image_file_name    :string
#  background_image_content_type :string
#  background_image_file_size    :integer
#  background_image_updated_at   :datetime
#  button_label                  :string
#  button_url                    :string
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  title_html_tag                :string
#

class Banner < ActiveRecord::Base
  attr_accessible *attribute_names

  has_attached_file :background_image
  attr_accessible :background_image

  do_not_validate_attachment_file_type :background_image

  before_save :set_default_title_html_tag

  def set_default_title_html_tag
    self.title_html_tag = "div" if self.title_html_tag.blank?
  end
end
