# == Schema Information
#
# Table name: wizard_promo_codes
#
#  id                  :integer          not null, primary key
#  password            :string           not null
#  percentage_discount :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Wizard::PromoCode < ActiveRecord::Base
  attr_accessible *attribute_names

  has_many :tests, class_name: Wizard::Test

  attr_accessible :promo_codes, :promo_code_ids



end
