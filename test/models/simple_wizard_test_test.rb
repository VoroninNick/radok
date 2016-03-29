# == Schema Information
#
# Table name: simple_wizard_tests
#
#  id                                              :integer          not null, primary key
#  tot__type_of_test                               :string
#  top__type_of_product                            :string
#  ps__platforms                                   :text
#  ps__hours                                       :string
#  pi__project_name                                :string
#  pi__project_version                             :string
#  pi__project_languages                           :text
#  pi__report_languages                            :text
#  tp__type_of_testing                             :string
#  tp__exploratory_instructions                    :text
#  tp__test_case_attachment_file_name              :string
#  tp__test_case_attachment_content_type           :string
#  tp__test_case_attachment_file_size              :integer
#  tp__test_case_attachment_updated_at             :datetime
#  pa__access_instructions_url                     :string
#  pa__access_instructions_attachment_file_name    :string
#  pa__access_instructions_attachment_content_type :string
#  pa__access_instructions_attachment_file_size    :integer
#  pa__access_instructions_attachment_updated_at   :datetime
#  pa__access_user_name                            :string
#  pa__access_password                             :string
#  pa__need_authorization                          :boolean
#  pa__comment                                     :text
#  created_at                                      :datetime         not null
#  updated_at                                      :datetime         not null
#  state                                           :text
#

require 'test_helper'

class SimpleWizardTestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
