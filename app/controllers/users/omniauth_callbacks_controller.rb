class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:


  #skip_before_filter
  skip_filter *_process_action_callbacks.map(&:filter)

  # def facebook
  #   render inline: params.inspect
  # end

  def specific_provider(name)
    #return render inline: params.keys.map(&:to_s).inspect
    #sign_in = params.keys.map(&:to_s).include?("sign-in")
    #sign_up = !sign_in

    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    #return render inline: "persisted: #{@user.persisted?.inspect}" + @user.inspect
    if @user.persisted?
      sign_in resource_name, @user
      redirect_to "/"
      # sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      #set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.#{name}_data"] = request.env["omniauth.auth"]
      #redirect_to new_user_registration_url
      #url_to_redirect = "/sign-up/facebook"
      #url_to_redirect = "/sign-in/facebook" if sign_in
      if @user.save
        sign_in resource_name, @user
      end
      redirect_to "/"
      #redirect_to "/sign-up/#{name}"
    end
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
    #return render inline: "hi"
    # derive target redirect route from 'resource_class' param, which was set
    # before authentication.

    #devise_mapping = request.env['omniauth.params']['resource_class'].underscore.to_sym
    #redirect_route = "/#{Devise.mappings[devise_mapping].as_json["path"]}/#{params[:provider]}/callback"

    # preserve omniauth info for success route
    session['dta.omniauth.auth'] = request.env['omniauth.auth']
    session['dta.omniauth.params'] = request.env['omniauth.params']

    redirect_route = "/users/auth/#{params[:provider]}/callback"
    redirect_to redirect_route
  end

  def omniauth_success
    super
  end

  def passthru
    #render inline: "hi"
    super
  end


  # def omniauth_success
  #   # find or create user by provider and provider uid
  #
  #   @resource = User.where({
  #                                        uid:      auth_hash['uid'],
  #                                        provider: auth_hash['provider']
  #                                    }).first_or_initialize
  #
  #   # create token info
  #   @client_id = SecureRandom.urlsafe_base64(nil, false)
  #   @token     = SecureRandom.urlsafe_base64(nil, false)
  #   @expiry    = (Time.now + DeviseTokenAuth.token_lifespan).to_i
  #
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



  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when omniauth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
