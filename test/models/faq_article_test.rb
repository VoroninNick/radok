# == Schema Information
#
# Table name: faq_articles
#
#  id           :integer          not null, primary key
#  published    :boolean
#  name         :string
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  url_fragment :string
#

require 'test_helper'

class FaqArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
