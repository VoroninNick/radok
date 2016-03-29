# == Schema Information
#
# Table name: wizard_tests
#
#  id                      :integer          not null, primary key
#  state                   :string
#  percent_completed       :float
#  hours_per_tester        :integer
#  project_name            :string
#  project_version         :string
#  methodology_type        :string
#  exploratory_description :text
#  project_url             :string
#  authentication_required :boolean
#  auth_login              :string
#  auth_password           :string
#  comment                 :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  product_type_id         :integer
#  test_type_id            :integer
#  user_id                 :integer
#  active_step_number      :integer
#  proceeded_steps_count   :integer
#  completed_at            :datetime
#  tested_at               :datetime
#  expected_tested_at      :datetime
#  successful              :boolean
#  current_step_id         :integer
#  total_price             :integer
#  main_components         :text
#  project_info_comment    :text
#  project_access_comment  :text
#  platforms_comment       :text
#  contact_person_name     :string
#  contact_person_phone    :string
#  contact_person_email    :string
#  admin_comment           :text
#  promo_code_id           :integer
#

require 'test_helper'

class Wizard::TestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
