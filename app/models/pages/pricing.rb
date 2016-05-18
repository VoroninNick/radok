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

class Pages::Pricing < Page

end
