# == Schema Information
#
# Table name: clients
#
#  id                :integer          not null, primary key
#  name              :string
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  sorting_position  :integer
#  client_url        :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
