class Leader < ActiveRecord::Base
  attr_accessible :name, :position
  attr_accessible :image

  has_attached_file :image, styles: { thumb: "150x150#" }
  do_not_validate_attachment_file_type :image

end
