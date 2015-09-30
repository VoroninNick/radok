#class Users::RegistrationsController < Devise::RegistrationsController
class Users::RegistrationsController < Devise::RegistrationsController
  #before_filter :configure_sign_up_params, only: [:create]
  #before_filter :configure_account_update_params, only: [:update]
  before_action :configure_permitted_parameters, only: [:create, :update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected


  def sign_up_params
    params.permit(:username, :email, :password, :password_confirmation, :full_name, :phone )
  end

  def account_update_params
    params.permit(:username, :full_name, :phone, :email, :country, :city, :zip_code, :billing_address)
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
