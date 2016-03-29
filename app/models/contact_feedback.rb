# == Schema Information
#
# Table name: contact_feedbacks
#
#  id          :integer          not null, primary key
#  name        :string
#  email       :string
#  subject     :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ContactFeedback < ActiveRecord::Base
  attr_accessible *attribute_names
end
