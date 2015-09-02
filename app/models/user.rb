class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable#,
         #:authentication_keys => [:login]
  include DeviseTokenAuth::Concerns::User
  
  attr_accessible :email, :password, :password_confirmation

  #attr_accessible :confirm_success_url, :config_name
  
  
  # User info
  attr_accessible :first_name
  attr_accessible :last_name
  attr_accessible :country
  attr_accessible :city
  attr_accessible :zip_code
  attr_accessible :company_url
  attr_accessible :username
  attr_accessible :image
  #attr_accessible :email
  attr_accessible :billing_cardholder_name
  attr_accessible :billing_address
  attr_accessible :billing_card_number
  attr_accessible :billing_cvv_number
  attr_accessible :full_name, :phone

  #attr_accessor :login

  def login
    @login || self.username || self.email
  end

  def login= val
    @login = val
  end

  def self.find_for_database_authentication(warden_conditions)
    raise ScriptError
    # conditions = warden_conditions.dup
    # #if login = conditions.delete(:login)
    #   #where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    # else
    #   #where(conditions.to_hash).first
    # end
    User.last
  end



end
