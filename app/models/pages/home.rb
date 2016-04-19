# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  type       :string
#  name       :string
#  content    :text
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Pages::Home < Page

  has_html_block :banner_1_title_with_description, :banner_2_title_with_description, :what_for_you, :statistics, :plans, :devices, :feedbacks, :bottom_block

  def self.default_url
    "/"
  end
end
