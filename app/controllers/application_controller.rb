class ApplicationController < ActionController::Base
  #include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionView::Helpers::OutputSafetyHelper
  include ActionView::Helpers::AssetUrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  include Cms::Helpers::MetaDataHelper
  include Cms::Helpers::ImageHelper
  include Cms::Helpers::PagesHelper
  include Rails.application.routes.url_helpers
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  #protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?

  respond_to :html, :json

  after_filter :set_csrf_cookie_for_ng

  rescue_from CanCan::AccessDenied do |exception|
    #redirect_to main_app.root_url, :alert => exception.message
    render template: "errors/access_denied", layout: "not_found"
  end

  def session_inspect
    return render inline: session.to_hash.inspect
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def geo
    ip = request.remote_ip
    geo_location = GeoIp.geolocation(ip)
    render json: geo_location
  end

  protected

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :confirm_success_url, :config_name, :full_name, :phone, :registration) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def authenticate

  end

  def menu_items
    unlogged_user_menu = [
        { title: "For clients",
          subitems: [
              {title: "Testing services", href: testing_services_path},
              {title: "Devices", href: devices_path},
              {title: "Pricing", href: pricing_path},
              {title: "FAQ", href: faq_path}
          ]
        },
        {title: "How it works", href: how_it_works_path},
        {title: "About us", href: about_path},
        {title: "Contact us", href: contact_path}
    ]

    logged_user_menu = [
        {title: "My dashboard", href: dashboard_path},
        {
            title: "For clients",
            subitems: [
                {title: "Testing services", href: testing_services_path},
                {title: "Devices", href: devices_path},
                {title: "How it works", href: how_it_works_path},
                {title: "Pricing", href: pricing_path},
                {title: "FAQ", href: faq_path}
            ]
        },
        {title: "About us", href: about_path},
        {title: "Contact us", href: contact_path}
    ]

    if current_user
      return logged_user_menu
    else
      return unlogged_user_menu
    end
  end

  def set_page_banner
    @banner ||= @page_instance.banner
  end


  def developer_machine?
    ActionMailer::Base.default_url_options[:host].scan(/localhost/).any?
  end

  def server_machine?
    !developer_machine?
  end

  def render_not_found
    render template: "errors/not_found", layout: 'not_found'
  end

  helper_method :developer_machine?, :server_machine?

  helper_method :menu_items


  #before_action :redirect_to_without_slash
  def redirect_to_without_slash
    url = request.original_url
    ends_with_slash = url.scan(/\/\Z/).any?
    is_root = home_path(only_path: false) == url
    if ends_with_slash && !is_root
      redirect_to url[0, url.length - 1], status: 301
    end


    # if ends_with_slash && (params[:format].blank? || params[:format].to_s != 'html' )
    #   str = request.original_url
    #   redirect_to str[0, str.length - 1]
    # end
  end
end
