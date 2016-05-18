# == Schema Information
#
# Table name: wizard_product_types
#
#  id                 :integer          not null, primary key
#  name               :string
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class Wizard::ProductTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
