# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  encrypted_password      :string           default(""), not null
#  reset_password_token    :string
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string
#  last_sign_in_ip         :string
#  confirmation_token      :string
#  confirmed_at            :datetime
#  confirmation_sent_at    :datetime
#  unconfirmed_email       :string
#  first_name              :string
#  last_name               :string
#  country                 :string
#  city                    :string
#  zip_code                :integer
#  company_url             :string
#  username                :string
#  image                   :string
#  email                   :string
#  billing_cardholder_name :string
#  billing_address         :string
#  billing_card_number     :string
#  billing_cvv_number      :string
#  full_name               :string
#  subscribed              :boolean
#  phone                   :string
#  avatar_file_name        :string
#  avatar_content_type     :string
#  avatar_file_size        :integer
#  avatar_updated_at       :datetime
#  created_at              :datetime
#  updated_at              :datetime
#  role                    :string
#  provider                :string
#  uid                     :string
#  saved_at                :datetime
#
class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :confirmable, :omniauthable

  self.omniauth_providers = [:facebook, :github, :google_oauth2,
                             :linkedin, :twitter]

  has_attached_file :avatar, styles: { profile_image: '120x120#',
                                       header_image: '40x40#' }
  has_many :tests, class_name: Wizard::Test

  attr_accessible *attribute_names
  attr_accessible :avatar, :delete_avatar
  attr_accessible :confirmed_at
  attr_accessible :confirm_success_url, :config_name
  attr_accessible :email, :password, :password_confirmation
  attr_writer :login
  do_not_validate_attachment_file_type :avatar
  validates :email, presence: true
  validates :email, uniqueness: true

  # User info

  def self.from_omniauth(auth)
    auth.try do |auth|
      user = where("(provider = ? and uid = ?) or email = ?",
             auth[:provider], auth[:uid], auth[:info][:email]).first
      user ||= new do |user|
        user.email = auth[:info][:email]
        user.password = Devise.friendly_token[0,20]
        # assuming the user model has a name
        user.first_name = auth[:info][:first_name]
        user.last_name = auth[:info][:last_name]
        user.provider = auth[:provider]
        # assuming the user model has an image
        user.avatar = auth.info.image.gsub(/\Ahttp:/, 'https:')
      end
    end
  end

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    #raise ScriptError
    # conditions = warden_conditions.dup
    # #if login = conditions.delete(:login)
    #   #where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    # else
    #   #where(conditions.to_hash).first
    # end

    local_login = warden_conditions[:login]
    local_password = warden_conditions[:password]
    # (username: local_login).or(email: local_login)
    user = User.where('username = ? or email = ?',
                      local_login, local_login).first
    # raise StandardError, "invalid_password" unless user.valid_password?(local_password)
    user
  end

  before_save do
    self.role = :user if role.blank?
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
    mailchimp.lists.subscribe(list_id, email: email)
    p '==================== subscribe ======================='
  end

  def unsubscribe(skip_errors = true)
    self.subscribed = false
    email = self.email
    list_id = MAILCHIMP_DEFAULT_LIST_ID
    mailchimp = Mailchimp::API.new(MAILCHIMP_API_KEY)
    mailchimp.lists.unsubscribe(list_id, email: email)
    p '==================== unsubscribe ======================='
  end

  def admin?
    role == 'admin'
  end

  def name_or_username
    first_name || username
  end

  def send_social_welcome_email(provider = nil)
    Users::Mailer.welcome_email(self, provider).deliver
  end
end
