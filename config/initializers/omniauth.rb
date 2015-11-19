require_relative 'settings'

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :github,        ENV['GITHUB_KEY'],   ENV['GITHUB_SECRET'],   scope: 'email,profile'
  #provider :facebook,      ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']

  #provider :facebook, "1594981080756392", "ecab8a1969ce2ca2e28a7d273c0ab784"
  #provider :facebook, "777676205684450", "1458fbcb799e3bbc7bbc94ac3812c43d"
  #provider :facebook, "574720446011703", "1a56643ae3aa26eb1008dae30118b620", scope: "email,public_profile"
  provider :facebook, Settings['omniauth.facebook.app_id'], Settings['omniauth.facebook.app_secret'], scope: "email,public_profile", info_fields: 'email'

  #provider :github, '7c153b36621a11e7671a', '6df628a3fb4e63869372972a0b5f94aba2e11fe6'#, scope: "user:email,user:follow"
  provider :github, Settings['omniauth.github.client_id'], Settings['omniauth.github.client_secret'], scope: "user:email"

  #provider :google_oauth2, "514836369419-inlr5a4im5bir2u2cl38sqsbdujtkqe4.apps.googleusercontent.com", "Dau-5iDpCwSGutY_C7R0INx5"
  provider :google_oauth2, Settings['omniauth.google_oauth2.client_id'], Settings['omniauth.google_oauth2.client_secret']

  #provider :linkedin, "77wi6ez9os0qxe", "WG85tBcFg8zpULDz"
  provider :linkedin, Settings['omniauth.linkedin.client_id'], Settings['omniauth.linkedin.client_secret']

  #provider :twitter, "lZqhSlmdgjljAZJCFWs4IIByX", "FGUh3keqrx8Qqdj0GawQ4La3ti4EEspv6NULyiI6lE2UdVHy6t"
  provider :twitter, Settings['omniauth.twitter.consumer_key'], Settings['omniauth.twitter.consumer_secret']

  #provider :google_oauth2, ENV['GOOGLE_KEY'],   ENV['GOOGLE_SECRET']
end