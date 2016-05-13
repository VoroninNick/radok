class Users::SessionsController < Devise::SessionsController
  # before_action :require_no_authentication, only: [:new, :create]
  prepend_before_action :require_no_authentication, only: [:new, :create]
  prepend_before_action :allow_params_authentication!, only: :create
  prepend_before_action :verify_signed_out_user, only: :destroy
  prepend_before_action only: [:create, :destroy] { request.env['devise.skip_timeout'] = true }

  # GET /resource/sign_in
  def new
    set_page_metadata('sign_in')
    super
  end

  # POST /resource/sign_in
  def create
    user_params = params[:user]
    from_oauth = false

    if user_params.blank?
      user_params = { email: social_params[:info][:email] }
      from_oauth = true
    end

    self.resource = user_signed_in? ? current_user : User.find_for_database_authentication(user_params)
    @user ||= User.from_omniauth(request.env['omniauth.auth'])

    if resource
      unless from_oauth || user_signed_in?
        unless resource.valid_password?(params[:user][:password])
          return render json: { user: { form_errors: ['invalid_password_or_login'] } }, status: 401
        end
      end

      unless resource.confirmed?
        return render json: { user: { errors: { login: :unconfirmed } } }, status: 401
      end

      test_ids = session[:tests]

      if test_ids.try(&:any?)
        Wizard::Test.where(id: test_ids).where('user_id is null').update_all(user_id: resource.id)
      end

      sign_in(resource_name, resource)

    else
      return render json: { user: { form_errors: ['invalid_password_or_login'] } }, status: 401
    end

    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def social_params
    [:facebook, :twitter, :linkedin, :google_oauth2].each do |provider_key|
      data = session["devise.#{provider_key}_data"]
      return data if data.present?
    end
  end

  protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_in) << :login
  end
end
