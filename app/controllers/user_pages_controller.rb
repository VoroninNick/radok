class UserPagesController < ApplicationController
  def registrations__new
    #return render inline: session["devise.facebook_data"].inspect
    @user = User.new

    provider = params[:provider]
    if provider == 'facebook'
      @user.email = facebook_data['info']['email']
      @user.username = facebook_data['info']['nickname']
      @user.full_name = facebook_data['info']['name']
    end

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

  def facebook_data
    session["devise.facebook_data"]
  end

  def profile
    @password_change_tab_active = flash[:forgot_password].present?
    @personal_data_tab_active = !@password_change_tab_active

    @user = current_user

    if @user.nil?
      authenticate_user!
    end

    if request.post?
      @user.update(params[:user])

      render json: {
                 user:
                     {avatar: {
                        profile_image: {
                            url: @user.avatar.url(:profile_image)
                        },
                        header_image: {
                            url: @user.avatar.url(:header_image)
                        }
                        }
                     }
             }, status: 200
    end
  end

  def update_subscription
    subscribe = params[:subscribe] == 'true'
    if subscribe
      current_user.subscribe!
    else
      current_user.unsubscribe!
    end

    render json: { }, status: 200
  end
end