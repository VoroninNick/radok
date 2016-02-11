module Templates
  class MailerTemplate < Page
    has_html_block :content

    def self.disabled
      true
    end
  end
end