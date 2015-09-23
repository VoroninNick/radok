class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    self.resource = User.find_for_database_authentication(params[:user])
    if resource
      unless resource.confirmed?
        return render json: { user: { errors: { login: :unconfirmed } } }, status: 401
      end

      resource.send_reset_password_instructions

      if successfully_sent?(resource)
        respond_with({user: resource}, location: after_sending_reset_password_instructions_path_for(resource_name))

      else
        respond_with(resource)
      end

    else
      return render json: { user: {form_errors: ["invalid_username_or_email"] } }, status: 401
    end



    yield resource if block_given?


  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
    render template: "user_pages/edit_password"
  end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
