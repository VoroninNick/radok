class FormConfig < ActiveRecord::Base
  attr_accessible *attribute_names

  def self.default_emails
    ['voronin.nick@gmail.com']
  end

  def emails
    em = (email_receivers || "").split(",")
    if em.empty?
      return self.class.default_emails
    else
      return em
    end
  end
end
