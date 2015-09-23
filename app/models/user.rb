class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable,# :validatable,
          :confirmable, :omniauthable#,
         #:authentication_keys => [:login]
  #include DeviseTokenAuth::Concerns::User

  attr_accessible *attribute_names
  
  attr_accessible :email, :password, :password_confirmation

  attr_accessible :confirm_success_url, :config_name

  has_attached_file :avatar, styles: { profile_image: "120x120#", header_image: "40x40#" }
  attr_accessible :avatar, :delete_avatar
  
  
  # User info


  #attr_accessor :login

  validates :username, :email, presence: true
  validates :email, :username, uniqueness: true

  def login
    @login || self.username || self.email
  end

  def login= val
    @login = val
  end

  def self.find_for_database_authentication(warden_conditions)
    #raise ScriptError
    # conditions = warden_conditions.dup
    # #if login = conditions.delete(:login)
    #   #where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    # else
    #   #where(conditions.to_hash).first
    # end

    puts "========================================"
    puts  self.name + "." + "find_for_database_authentication: "
    puts warden_conditions.inspect
    puts "========================================"

    local_login = warden_conditions[:login]
    local_password = warden_conditions[:password]

    user = nil

    user = User.where("username = ? or email = ?", local_login, local_login).first #(username: local_login).or(email: local_login)
    #raise StandardError, "invalid_password" unless user.valid_password?(local_password)
    user
  end


  #def valid_password?

  #end


  def subscribe!
    subscribe
    save!
  end

  def unsubscribe!
    unsubscribe
    save!
  end

  def subscribe
    self.subscribed = true
  end

  def unsubscribe
    self.subscribed = false
  end



end
