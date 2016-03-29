# == Schema Information
#
# Table name: wizard_manufacturers
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Wizard::Manufacturer < ActiveRecord::Base
  attr_accessible *attribute_names

  has_many :devices
  attr_accessible :devices


end
