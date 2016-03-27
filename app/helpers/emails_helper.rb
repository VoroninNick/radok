module EmailsHelper
  def email
    "office@10g-force.com"
  end

  def phone
    "+1-514-585-8198"
  end

  def formatted_phone_number
    "+1-888-535-4852"
  end

  def site_url
    "http://10g-force.com"
  end

  def img_url(relative_url)
    "#{site_url}/assets/#{relative_url}"
  end
end
