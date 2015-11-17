class ApplicationMailer < ActionMailer::Base

  include Devise::Mailers::Helpers
  include EmailsHelper
  include Roadie::Rails::Automatic

  helper :emails


  default from: "10G-Force team <info@10g-force.com>"
  layout 'users/mailer'



end
