class Client < ActiveRecord::Base
  attr_accessible *attribute_names
  attr_accessible :logo

  has_attached_file :logo, styles: { thumb: "150x150#" }
  do_not_validate_attachment_file_type :logo

end
