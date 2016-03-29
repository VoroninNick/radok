# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  type       :string
#  name       :string
#  content    :text
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Templates
  class MailerTemplate < Page
    has_html_block :content

    def self.disabled
      true
    end
  end
end
