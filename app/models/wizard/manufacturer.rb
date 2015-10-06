class Wizard::Manufacturer < ActiveRecord::Base
  attr_accessible *attribute_names

  has_many :devices
  attr_accessible :devices


end
