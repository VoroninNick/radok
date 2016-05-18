# == Schema Information
#
# Table name: leaders
#
#  id                 :integer          not null, primary key
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  name               :string
#  position           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Leader < ActiveRecord::Base
  attr_accessible *attribute_names
  attr_accessible :image

  has_attached_file :image, styles: { thumb: "150x150#" }
  do_not_validate_attachment_file_type :image

end
