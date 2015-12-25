class WizardText < ActiveRecord::Base
  attr_accessible *attribute_names

  fields :wizard_help_slim
end
