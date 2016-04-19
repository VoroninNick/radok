class Users::Mailer < ApplicationMailer
  # include Devise::Mailers::Helpers
  # include EmailsHelper
  # include Roadie::Rails::Automatic
  #
  # helper :emails
  #
  #
  # layout "users/mailer"

  def confirmation_instructions(record, token, opts={})
    @token = token
    #self.send :extend, EmailsHelper
    devise_mail(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions(record, token, opts={})
    @token = token
    devise_mail(record, :reset_password_instructions, opts)
  end

  def unlock_instructions(record, token, opts={})
    @token = token
    devise_mail(record, :unlock_instructions, opts)
  end

  def welcome_email(record, provider = nil, opts = {})
    @provider = provider
    devise_mail(record, :welcome_email, opts)
  end
end
