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

class Pages::Devices < Page
  has_html_block :intro, :devices_in_numbers
end
