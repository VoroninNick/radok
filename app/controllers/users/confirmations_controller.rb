class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  def create
    local_login = params[:user][:login]
    user = User.where("username = ? or email = ?", local_login, local_login).first
    user_params = {email: user.email}
    self.resource = resource_class.send_confirmation_instructions(user_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    super
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    #super(resource_name, resource)
    if signed_in?(resource_name)
      signed_in_root_path(resource)
    else
      root_path
    end
  end
end
