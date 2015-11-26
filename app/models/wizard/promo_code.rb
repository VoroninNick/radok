class Wizard::PromoCode < ActiveRecord::Base
  attr_accessible *attribute_names

  has_many :tests, class_name: Wizard::Test

  attr_accessible :promo_codes, :promo_code_ids



end
