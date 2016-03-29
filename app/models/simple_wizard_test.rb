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

class SimpleWizardTest < ActiveRecord::Base
  attr_accessible :tot__type_of_test
  attr_accessible :top__type_of_product
  attr_accessible :ps__platforms
  attr_accessible :ps__hours
  attr_accessible :pi__project_name
  attr_accessible :pi__project_version
  attr_accessible :pi__project_languages
  attr_accessible :pi__report_languages
  attr_accessible :tp__type_of_testing
  attr_accessible :tp__exploratory_instructions
  #t.has_attached_file :tp__test_case_attachment
  attr_accessible :pa__access_instructions_url
  #t.has_attached_file :pa__access_instructions_attachment
  attr_accessible :pa__access_user_name
  attr_accessible :pa__access_password
  attr_accessible :pa__need_authorization
  attr_accessible :pa__comment

  attr_accessible :state

  before_save :generate_name
  def generate_name
    pi__project_name = "Project-#{rand(1000)}"
  end

  def parse_state
    s = state
    if s.present?
      state = JSON.parse(s)
    end
  end

  [:tp__test_case_attachment, :pa__access_instructions_attachment].each do |attr|
    attr_accessible :"#{attr}_file_name" , :"#{attr}_content_type" , :"#{attr}_file_size", :"#{attr}_updated_at"
  end


end
