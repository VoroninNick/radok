require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RadokForce
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    I18n.available_locales = [:json, :en]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.assets.precompile += %w(modernizr-all.min.js not_found.css mailer.css)

    #config.assets.precompile += %w(codemirror.js codemirror/*)
    config.assets.precompile += %w(templates.css templates.js wizard_js.js payment_form.js)

    # Use Bower packages in assets pipeline
    config.assets.paths << \
      Rails.root.join('vendor', 'assets', 'bower_components')
    config.assets.paths << \
      Rails.root.join('vendor', 'assets', 'bower_components', 'footable', 'css', 'fonts')

    config.assets.precompile << /.*.(?:eot|svg|ttf|woff|woff2)$/

    PayPal::SDK::Core::Config.load('config/paypal.yml',  ENV['RACK_ENV'] || 'development')
    PayPal::SDK.logger = Logger.new(STDERR)
    PayPal::SDK.logger.level = Logger::INFO
  end
end
