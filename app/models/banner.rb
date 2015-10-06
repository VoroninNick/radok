class Banner < ActiveRecord::Base
  attr_accessible *attribute_names

  has_attached_file :background_image
  attr_accessible :background_image

  do_not_validate_attachment_file_type :background_image
end
