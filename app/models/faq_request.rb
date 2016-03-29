# == Schema Information
#
# Table name: faq_requests
#
#  id          :integer          not null, primary key
#  name        :string
#  email       :string
#  subject     :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class FaqRequest < ActiveRecord::Base
  attr_accessible *attribute_names
end
