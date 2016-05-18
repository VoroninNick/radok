class UserPagesController < ApplicationController
  def registrations__new
    @user = User.new
    set_page_metadata('sign_up')
    provider = params[:provider]
    if provider == 'facebook'
      @user.email = social_params['info']['email']
      @user.username = social_params['info']['nickname']
      @user.full_name = social_params['info']['name']
    end
    render 'user_pages/static_sign_up'
  end

  def registrations__create
    @user = User.new
    @user.update_attributes(params[:user])

    I18n.with_locale :json do
      @status = @user.save ? 200 : 422
      render 'user_pages/show.json', status: @status
    end
  end

  def facebook_data
    session['devise.facebook_data']
  end

  def social_params(provider = :any)
    available_providers = [:facebook, :twitter, :linkedin, :google_oauth2]
    unless provider == :any || !provider.to_s.in?(available_providers)
      return session["devise.#{provider}_data"]
    end
    available_providers.each do |provider_key|
      data = session["devise.#{provider_key}_data"]
      return data if data.present?
    end
  end

  def user_logged
    render json: { logged: !!user_signed_in? }
  end

  def profile
    @password_change_tab_active = flash[:forgot_password].present?
    @personal_data_tab_active = !@password_change_tab_active
    @user = current_user
    authenticate_user! if @user.nil?

    set_page_metadata('profile')

    if request.post?
      @user.update(params[:user])

      render json: {
        user:
          { avatar: {
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
      begin
        current_user.subscribe
      rescue Exception => e
        if e.class.name == 'Mailchimp::ListInvalidUnsubMemberError'
          current_user.send_resubscribe_confirmation
        else
          return render json: { code: e.message }, status: 400
        end
      end
    else
      current_user.unsubscribe!
    end
    render json: {}, status: 200
  end

  def subscribe
    email = params[:email]
    user = User.find_by(email: email) || User.new(email: email)
    return render json: { subscribed: true }, status: 400 if user.subscribed?
    begin
      user.subscribe
    rescue Exception => e
      return render json: { code: e.message }, status: 400
    end
    render json: {}, status: 200
  end

  def subscribe_callback
    @user = User.find_by(email: params[:data][:email])
    if request.post? && !!@user
      @user.subscribed = true if params[:type] == 'subscribe'
      @user.subscribed = false if params[:type] == 'unsubscribe'
      @user.save!
    end
    render nothing: true
  end
end
