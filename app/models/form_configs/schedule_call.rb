# == Schema Information
#
# Table name: form_configs
#
#  id              :integer          not null, primary key
#  type            :string
#  email_receivers :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class FormConfigs::ScheduleCall < Cms::FormConfig

end
