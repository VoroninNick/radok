class ApplicationMailer < ActionMailer::Base

  include Devise::Mailers::Helpers
  include EmailsHelper
  include Roadie::Rails::Automatic

  helper :emails
  include Cms::Helpers::PagesHelper


  default from: "10G-Force team <info@10g-force.com>"
  layout 'users/mailer'

  def confirm_resubscribe(email, opts={})
    mail(
        template_path: "mailers",
        template_name: "mailchimp_subscribe",
        to: email,
        subject: "10G Force subscribe request"
    )
  end
end
