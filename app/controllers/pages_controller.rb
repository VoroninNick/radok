class PagesController < ApplicationController
  include ApplicationHelper
  before_action :set_page_metadata
  before_action :set_page_banner, except: [:home, :robots_txt]

  def self.actions
    self.instance_methods.sort - self.superclass.instance_methods - %w(default set_page_metadata).map(&:to_sym)
  end

  def default
    initial_template = params[:initial_template]
    if template_exists?(initial_template)
      render initial_template
    end
  end

  def pricing
    banner_url = Rails.root.join('fixtures', 'images', 'radok-web-banner-pricing.png')
    @banner = Banner.new(title: 'Pricing', description: 'Select the testing solutions that meet Your needs')
    @banner.attach_background_image(banner_url)
    render 'default'
  end

  def how_it_works
    banner_url = Rails.root.join('fixtures', 'images', 'radok-web-banner-testing-services.png')
    @banner = Banner.new
    # @banner = Banner.new(title: 'Testing services', description: '- Only 3 easy steps to make Your web app/web work bugless!')
    @banner.attach_background_image(banner_url)
  end

  def testing_services
    banner_url = Rails.root.join('fixtures', 'images', 'radok-web-banner-testing-services.png')
    @banner = Banner.new(title: 'The level of testing you need')
    @banner.attach_background_image(banner_url)
  end

  def about
    @product_types = Wizard::ProductType.all
    @leaders = nil
    @clients = Client.all.sort_by_sorting_position
    banner_url = Rails.root.join('fixtures', 'images', 'radok-web-banner-about-us.png')
    @banner = Banner.new(title: '1500 certified testers', description: 'Young team of professional testers.')
    @banner.attach_background_image(banner_url)
  end

  def contact
    banner_url = Rails.root.join('fixtures', 'images', 'radok-web-banner-contacts.jpg')
    @banner = Banner.new
    @banner.attach_background_image(banner_url)
  end

  def home
    @home_slides = [
      {images: [
        ActionController::Base.helpers.asset_path('radok-web-banner-layer-1.png'),
        ActionController::Base.helpers.asset_path('radok-web-banner-layer-2.png'),
        ActionController::Base.helpers.asset_path('radok-web-banner-layer-3.png')],
        title: 'We test mobile, web apps and games.',
        description: 'Professional crowd testing team are ready to start testing your software product immediately',
        button: {
          title: 'Start now',
          subtitle: ('no registration required' unless current_user),
          svg: 'rf-rocket-up-right.svg',
          class: 'start-now-button',
          sref: 'wizard', href: wizard_path
        }
      },
      {images: [
        ActionController::Base.helpers.asset_path('banners/2/radok-web-banner2-layer-1.png'),
        ActionController::Base.helpers.asset_path('banners/2/radok-web-banner2-layer-2b.png'),
        ActionController::Base.helpers.asset_path('banners/2/radok-web-banner2-layer-3b.png')],
        title: 'We have a bunch of different devices to test on',
        description: 'Professional crowd testing team are ready to start testing your software product immediately',
        button: {
          title: 'Check out',
          svg: 'rf-rocket-up-right.svg',
          class: 'start-now-button',
          sref: 'wizard',
          href: devices_path
        }
      }
    ]

    @three_images_in_row_model = [
      {
        img: 'rf-icon-main-1.svg',
        title: 'Tell us what you need to test',
        time:'Takes less than 10 minutes!',
        description: 'Choose the type of testing you need, amount of hours to be spent, number of people involved and platforms you want your product be tested on. No sign-up or credit card required.'
      },
      {
        img:'rf-icon-main-2.svg',
        title: 'Submit your request',
        time: '2-3 minutes',
        description: 'Submit your request and our engineers will do the rest! So sit back and relax our team of 1500+ testing professionals are ready to start immediately.'
      },
      {
        img: 'rf-icon-main-3.svg',
        title: 'Get rapid results',
        time: '48 hours',
        description: 'In no more than 48 hours, you will receive a detailed bug report with your carefully documented test cases. If you need results faster, please contact us and we will try to accomdate your request.'
      }
    ]
  end

  def devices
    @devices = Wizard::Device.all

    @statistics = {
        title: 'Devices in numbers',
        devices_count: 109,
        manufacturers_count: 21,
        operating_systems: 48,
        screen_sizes: 25
    }
    banner_url = Rails.root.join('fixtures', 'images', 'radok-web-banner-device-lab.png')
    @banner = Banner.new(title: 'Device Lab', description: 'Test devices')
    @banner.attach_background_image(banner_url)
  end

  def robots_txt
    render template: 'pages/robots.txt'
  end

  def terms_of_use
  end
end
