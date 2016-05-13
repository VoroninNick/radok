class Users::ConfirmationsController < Devise::ConfirmationsController
  # POST /resource/confirmation
  def create
    local_login = params[:user][:login]
    user = User.where('username = ? OR email = ?', local_login, local_login).first
    user_params = { email: user.email }
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
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?
    if resource.errors.empty?
      sign_in(resource)
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      uncompleted_tests = current_user.tests
      anonymous_test_ids = session[:tests]
      test_ids = session[:tests]
      if test_ids.try(&:any?)
        Wizard::Test.where(id: test_ids).where('user_id IS NULL').update_all(user_id: (resource.id ))
      end
      respond_with_navigational(resource) do
        redirect_to(after_confirmation_path_for(resource_name, resource),
                    flash: {
                      confirmation_congratulations: true,
                      uncompleted_tests: uncompleted_tests,
                      anonymous_test_ids: anonymous_test_ids
                    })
      end
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity) { render :new }
    end
  end

  protected

  def after_confirmation_path_for(resource_name, resource)
    if signed_in?(resource_name)
      signed_in_root_path(resource)
    else
      home_path
    end
  end
end
