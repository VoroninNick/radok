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

require 'test_helper'

class BannerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
