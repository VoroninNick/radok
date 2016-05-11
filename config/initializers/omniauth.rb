require_relative 'settings'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['omniauth.facebook.app_id'], ENV['omniauth.facebook.app_secret'], scope: "email,public_profile", info_fields: 'email'
  provider :github, ENV['omniauth.github.client_id'], ENV['omniauth.github.client_secret'], scope: "user:email"
  provider :google_oauth2, ENV['omniauth.google_oauth2.client_id'], ENV['omniauth.google_oauth2.client_secret'], prompt: 'select_account', provider_ignores_state: true
  provider :linkedin, ENV['omniauth.linkedin.client_id'], ENV['omniauth.linkedin.client_secret']
  provider :twitter, ENV['omniauth.twitter.consumer_key'], ENV['omniauth.twitter.consumer_secret']
end
