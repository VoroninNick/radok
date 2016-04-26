# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  first_name             :string
#  last_name              :string
#  country                :string
#  city                   :string
#  zip_code               :integer
#  company_url            :string
#  username               :string
#  image                  :string
#  email                  :string
#  full_name              :string
#  subscribed             :boolean
#  phone                  :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :string
#  provider               :string
#  uid                    :string
#  saved_at               :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable,# :validatable,
          :confirmable, :omniauthable#,
         #omniauth_providers: [:facebook]
          #,
         #:authentication_keys => [:login]
  #include DeviseTokenAuth::Concerns::User

  self.omniauth_providers = [:facebook, :github, :google_oauth2, :linkedin, :twitter]

  has_many :tests, class_name: Wizard::Test

  attr_accessible *attribute_names
  attr_accessible :confirmed_at

  attr_accessible :email, :password, :password_confirmation

  attr_accessible :confirm_success_url, :config_name

  has_attached_file :avatar, styles: { profile_image: "120x120#", header_image: "40x40#" }#, url: "/system/users/avatars/:id/:style/:filename.:extension"
  attr_accessible :avatar, :delete_avatar

  do_not_validate_attachment_file_type :avatar


  # User info

  #attr_accessor :login

  validates :email, presence: true
  validates :email, uniqueness: true

  def self.from_omniauth(auth)
    auth.try do |auth|
      user = where("(provider = ? and uid = ?) or email = ?", auth[:provider], auth[:uid], auth[:info][:email]).first
      user ||= new do |user|
        user.email = auth[:info][:email]
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth[:info][:first_name]   # assuming the user model has a name
        user.last_name = auth[:info][:last_name]
        user.provider = auth[:provider]

        user.avatar = auth.info.image.gsub(/\Ahttp:/, "https:") # assuming the user model has an image
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


  def subscribe!(skip_errors = true)
    subscribe
    save!
  end

  def unsubscribe!(skip_errors = true)
    unsubscribe
    save!
  end

  def subscribe(skip_errors = true)
    self.subscribed = true
    email = self.email
    list_id = MAILCHIMP_DEFAULT_LIST_ID
    mailchimp = Mailchimp::API.new(MAILCHIMP_API_KEY)
    mailchimp.lists.subscribe(list_id, {email: email})
  end

  def unsubscribe(skip_errors = true)
    self.subscribed = false
    email = self.email
    list_id = MAILCHIMP_DEFAULT_LIST_ID
    mailchimp = Mailchimp::API.new(MAILCHIMP_API_KEY)
    mailchimp.lists.unsubscribe(list_id, {email: email})
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

  def send_social_welcome_email(provider = nil)
    Users::Mailer.welcome_email(self, provider).deliver
  end

end
