# == Schema Information
#
# Table name: wizard_texts
#
#  id         :integer          not null, primary key
#  json_data  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WizardText < ActiveRecord::Base
  attr_accessible *attribute_names

  fields :wizard_help_slim
end
