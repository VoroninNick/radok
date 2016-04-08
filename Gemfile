source 'https://rubygems.org'
require_relative "bin/bundler_extensions"

# Base
gem 'rails',                  '~> 4.2.1'
gem 'rake',                   '10.5.0'
gem 'pg',                     '~> 0.18.4'
gem 'json_schema_builder',    '~> 0.0.6'
gem 'thin',                   '~> 1.6.3'
gem 'ancestry',               '~> 2.1.0'
gem 'protected_attributes',   '~> 1.0.8'
gem 'paperclip',              '~> 4.2.1'
gem 'aws-sdk',                '< 2'
gem 'figaro',                 '~> 1.1.1'
gem 'responders',             '~> 2.1.0'
gem 'ruby-debug-ide',         '~> 0.4.32'
gem 'debase',                 '~> 0.1.4'
gem 'global_config',          '~> 0.1.2'
gem 'composite_primary_keys', '~> 8.1.2'
gem 'enumerize',              '~> 1.1.1'
gem 'pluck_to_hash',          '~> 0.2.0'
gem 'timespan',               :git => 'git://github.com/toxaq/timespan.git'
gem 'roadie-rails',           '~> 1.1.0'
gem 'opal',                   '~> 0.9.2'
gem 'rails_config',           '~> 0.99.0'
gem 'activerecord-session_store', '~> 0.1.2'
gem 'pry-rails',              '~> 0.3.4'
gem 'require_reloader',       '~> 0.2.0'
gem 'rack-page_caching',      '~> 0.0.3'
gem 'mailchimp-api',          '~> 2.0.6', require: 'mailchimp'

# Assets HTML and Helpers
gem 'sass-rails',             '~> 5.0'
gem 'uglifier',               '>= 1.3.0'
gem 'coffee-rails',           '~> 4.1.0'
gem 'turbolinks',             '~> 2.5.3'
gem 'jbuilder',               '~> 2.0'
gem 'slim-rails',             '~> 3.0.1'
gem 'bower-rails',            '~> 0.9.2'
gem 'sdoc',                   '~> 0.4.0', group: :doc
gem 'ckeditor',               '~> 4.1.1'
gem 'simple_form',            '~> 3.1.0'
gem 'angular-rails-templates', '~> 0.1.4'
gem 'quiet_assets',           '~> 1.1.0'
gem 'html2slim',              '~> 0.2.0'
gem 'htmlcompressor',         '~> 0.2.0'
gem 'react-rails',            '~> 1.6.2'

# Auth
gem 'geo_ip',                 '~> 0.5.0'
gem 'devise',                 '~> 3.4.1'
gem 'omniauth',               '~> 1.2.2'
gem 'omniauth-google-oauth2', '~> 0.2.8'
gem 'omniauth-linkedin-oauth2', '~> 0.1.5'
gem 'omniauth-twitter',       '~> 1.2.1'
gem 'omniauth-github',        '~> 1.1.2'
gem 'omniauth-facebook',      '~> 2.0.1'
gem 'rails_admin_nestable',   '~> 0.3.2'
gem 'rails_admin',            '~> 0.6.6'
gem 'cancancan',              '~> 1.13.1'

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end

if ENV["LOCAL"]
  gem 'cms', path: "/media/data/pasha/gems/cms"
  gem "attachable", path: "/media/data/pasha/gems/attachable"
else
  gem 'cms', github: 'pkorenev/cms', ref: 'bd85727'
  gem "attachable", github: "VoroninNick/attachable"
end
