class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    begin
      self.resource = User.find_for_database_authentication(params[:user])
    rescue StandardError
      return render inline: "invalid password"
    end
    #return render inline:
    return render json: { user: { errors: { login: :unconfirmed } } }, status: 401 unless resource.confirmed?
    set_flash_message(:notice, :signed_in) if is_flashing_format?

    sign_in(resource_name, resource)
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
