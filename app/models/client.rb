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

class Client < ActiveRecord::Base
  attr_accessible *attribute_names
  attr_accessible :logo

  has_attached_file :logo, styles: { thumb: "150x150#" }
  do_not_validate_attachment_file_type :logo

  scope :sort_by_sorting_position, -> { order("sorting_position asc") }

end
