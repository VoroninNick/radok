module EmailsHelper
  def email
    ENV['mailer.yandex.email']
  end

  def phone
    ENV['contact.phone']
  end

  def formatted_phone_number
    ENV['contact.phone']
  end

  def site_url
    ENV['mailer.host']
  end

  def terms_url
    site_url + '/terms_of_use'
  end

  def skype_login
    ENV['contact.skype']
  end
end
