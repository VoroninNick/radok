class UserPagesController < ApplicationController
  def registrations__new
    render "user_pages/static_sign_up"
  end

  def registrations__create
    @user = User.new
    @user.update_attributes(params[:user])

    I18n.with_locale :json do
      if @user.save
        render "user_pages/show.json"
      else
        render "user_pages/show.json", status: 422
      end
    end


    #render "user_pages/static_sign_up"
  end

  def profile
    @personal_data_tab_active = true
    @user = current_user
    if @user.nil?
      authenticate_user!
    end
  end

  def update_subscription
    subscribe = params[:subscribe] == 'true'
    if subscribe
      current_user.subscribe!
    else
      current_user.unsubscribe!
    end

    render json: {}, status: 200
  end
end