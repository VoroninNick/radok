class UserPagesController < ApplicationController
  def registrations__new
    #return render inline: session["devise.facebook_data"].inspect
    #return render inline: social_params(params[:provider]).inspect
    @user = User.new

    set_page_metadata("sign_up")

    provider = params[:provider]
    if provider == 'facebook'
      @user.email = social_params['info']['email']
      @user.username = social_params['info']['nickname']
      @user.full_name = social_params['info']['name']
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

  def social_params(provider = :any)
    available_providers = [:facebook, :twitter, :linkedin, :google_oauth2]

    if provider == :any || !provider.to_s.in?(available_providers)
      available_providers.each do |provider_key|
        data = session["devise.#{provider_key}_data"]
        return data if data.present?
      end
    else
      return session["devise.#{provider}_data"]
    end
  end

  def user_logged
    render json: { logged: !!user_signed_in?}
  end

  def profile
    @password_change_tab_active = flash[:forgot_password].present?
    @personal_data_tab_active = !@password_change_tab_active

    @user = current_user

    if @user.nil?
      authenticate_user!
    end

    set_page_metadata("profile")

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

    render json: {}, status: 200
  end

  def subscribe
    email = params[:email]
    u = User.find_by(email: email) || User.new(email: email)
    return render json: {subscribed: true}, status: 400 if u.subscribed?

    begin
      u.subscribe
    rescue Exception => e
      return render json: { code: e.message }, status: 400
    end

    render json: {}, status: 200
  end
end
