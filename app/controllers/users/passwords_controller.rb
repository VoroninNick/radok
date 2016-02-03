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
    #render template: "user_pages/edit_password"
    pt = params[:reset_password_token]
    built_token = Devise.token_generator.digest(User, :reset_password_token, pt)
    user = User.where(reset_password_token: built_token).first
    if user
      sign_in(resource_name, user)
      redirect_to "/profile", flash: { forgot_password: true }
    end

  end

  # PUT /resource/password
  def update
    #super
    new_password = params[:user][:password]
    user = User.find(current_user.id)
    if user.valid_password?(new_password)
      return render json: { success: false, error: {identical: true} }, status: 400
    end

    if user.update(password: new_password)
      #user.password = new_password
     # sign_in(resource_name, user)
      #if user.save
      sign_in user, :bypass => true
      render json: { success: true }, status: 200
      #end
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
