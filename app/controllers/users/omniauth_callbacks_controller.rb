# Omniauth Registrations and Sessions
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_filter *_process_action_callbacks.map(&:filter)
  skip_before_filter :verify_authenticity_token

  def specific_provider(name)
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in resource_name, @user
    else
      session["devise.#{name}_data"] = request.env['omniauth.auth']
      @user.skip_confirmation!
      @user.saved_at = DateTime.now
      if @user.save!
        @user.send_social_welcome_email(name)
        sign_in :user, @user
      end
    end
    redirect_to "/"
  end

  def facebook
    specific_provider(:facebook)
  end

  def twitter
    specific_provider(:twitter)
  end

  def linkedin
    specific_provider(:linkedin)
  end

  def google_oauth2
    specific_provider(:google_oauth2)
  end

  def github
    specific_provider(:github)
  end

  def redirect_callbacks
    session['data.omniauth.auth'] = request.env['omniauth.auth']
    session['data.omniauth.params'] = request.env['omniauth.params']

    redirect_route = "/users/auth/#{params[:provider]}/callback"
    redirect_to redirect_route
  end

  def omniauth_success
    super
  end

  def passthru
    return render inline: request.referer
  end

  # def omniauth_success
  #   # find or create user by provider and provider uid
  #   @resource = User.where({
  #                                        uid:      auth_hash['uid'],
  #                                        provider: auth_hash['provider']
  #                                    }).first_or_initialize
  #
  #   # create token info
  #   @client_id = SecureRandom.urlsafe_base64(nil, false)
  #   @token     = SecureRandom.urlsafe_base64(nil, false)
  #   @expiry    = (Time.now + DeviseTokenAuth.token_lifespan).to_i
  #   @auth_origin_url = generate_url(omniauth_params['auth_origin_url'], {
  #                                                                         token:     @token,
  #                                                                         client_id: @client_id,
  #                                                                         uid:       @resource.uid,
  #                                                                         expiry:    @expiry
  #                                                                     })
  #
  #   # set crazy password for new oauth users. this is only used to prevent
  #   # access via email sign-in.
  #   unless @resource.id
  #     p = SecureRandom.urlsafe_base64(nil, false)
  #     @resource.password = p
  #     @resource.password_confirmation = p
  #   end
  #
  #   @resource.tokens[@client_id] = {
  #       token: BCrypt::Password.create(@token),
  #       expiry: @expiry
  #   }
  #
  #   # sync user info with provider, update/generate auth token
  #   assign_provider_attrs(@resource, auth_hash)
  #
  #   # assign any additional (whitelisted) attributes
  #   extra_params = whitelisted_params
  #   @resource.assign_attributes(extra_params) if extra_params
  #
  #   # don't send confirmation email!!!
  #   @resource.skip_confirmation!
  #
  #   sign_in(:user, @resource, store: false, bypass: false)
  #
  #   @resource.save!
  #
  #   # render user info to javascript postMessage communication window
  #   respond_to do |format|
  #     format.html { render :layout => "omniauth_response", :template => "devise_token_auth/omniauth_success" }
  #   end
  # end

  # protected

  # The path used when omniauth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
