class Wizard::Platform < ActiveRecord::Base
  attr_accessible *attribute_names
  has_ancestry

  has_and_belongs_to_many :product_types, class_name: Wizard::ProductType, join_table: :wizard_platforms_product_types
  attr_accessible :product_types, :product_type_ids

  has_many :test_platforms_bindings, class_name: Wizard::TestPlatform#, foreign_key: [:test_id, :platform_id]
  has_many :tests, class_name: Wizard::Platform, through: :test_platforms_bindings

  has_attached_file :avatar

  do_not_validate_attachment_file_type :avatar

  scope :by_test_id, ->(test_id) do
    #platform_ids = Wizard::TestPlatform.where(test_id: test_id).pluck(:platform_id); where(id: platform_ids)
    joins(:test_platforms_bindings).where(wizard_test_platforms: { test_id: test_id })
  end




  def recursive_to_hash
    res = {name: name, id: id}
    res[:avatar_url] = avatar.url if avatar.exists?
    res[:children] = children.pluck_to_hash(:id, :name)

    res
  end
end
