class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    #return render inline: social_params.inspect
    user_params = params[:user]
    from_oauth = false
    if user_params.blank?
      user_params = {email: social_params['info']['email']}
      from_oauth = true
    end
    self.resource = User.find_for_database_authentication(user_params)

    @user ||= User.from_omniauth(request.env["omniauth.auth"])


    if resource
      unless from_oauth
        unless  resource.valid_password?(params[:user][:password])
          return render json: { user: {form_errors: ["invalid_password_or_login"] } }, status: 401
        end
      end

      unless resource.confirmed?
        return render json: { user: { errors: { login: :unconfirmed } } }, status: 401
      end

      sign_in(resource_name, resource)

    else
      return render json: { user: {form_errors: ["invalid_password_or_login"] } }, status: 401
    end
    #return render inline:

    set_flash_message(:notice, :signed_in) if is_flashing_format?


    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def social_params
    [:facebook, :twitter, :linkedin, :google_oauth2].each do |provider_key|
      data = session["devise.#{provider_key}_data"]
      return data if data.present?
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_in) << :login
  end
end
