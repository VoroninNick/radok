class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create

    self.resource = User.find_for_database_authentication(params[:user])

    @user ||= User.from_omniauth(request.env["omniauth.auth"])


    if resource
      unless resource.valid_password?(params[:user][:password])
        return render json: { user: {form_errors: ["invalid_password_or_login"] } }, status: 401
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
