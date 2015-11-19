class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable,# :validatable,
          :confirmable, :omniauthable#,
         #omniauth_providers: [:facebook]
          #,
         #:authentication_keys => [:login]
  #include DeviseTokenAuth::Concerns::User

  self.omniauth_providers = [:facebook, :github, :google_oauth2, :linked_in]

  has_many :tests, class_name: Wizard::Test

  attr_accessible *attribute_names
  
  attr_accessible :email, :password, :password_confirmation

  attr_accessible :confirm_success_url, :config_name

  has_attached_file :avatar, styles: { profile_image: "120x120#", header_image: "40x40#" }#, url: "/system/users/avatars/:id/:style/:filename.:extension"
  attr_accessible :avatar, :delete_avatar

  do_not_validate_attachment_file_type :avatar
  
  
  # User info



  #attr_accessor :login

  validates :username, :email, presence: true
  validates :email, :username, uniqueness: true

  def self.from_omniauth(auth)
    auth.try do |auth|
      where("(provider = ? and uid = ?) or email = ?", auth[:provider], auth[:uid], auth[:info][:email]).first_or_create do |user|
        user.email = auth[:info][:email]
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth[:info][:first_name]   # assuming the user model has a name
        user.last_name = auth[:info][:last_name]
        #user.image = auth.info.image # assuming the user model has an image
      end
    end
  end

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

  before_save do
    self.role = :user if self.role.blank?
  end


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


  def admin?
    self.role == "admin"
  end


  def name_or_username
    if first_name.present?
      return first_name
    end

    return username
  end

end
