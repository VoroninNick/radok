Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :github,        ENV['GITHUB_KEY'],   ENV['GITHUB_SECRET'],   scope: 'email,profile'
  #provider :facebook,      ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']

  provider :facebook, "1594981080756392", "ecab8a1969ce2ca2e28a7d273c0ab784"

  provider :github, '7c153b36621a11e7671a', '6df628a3fb4e63869372972a0b5f94aba2e11fe6'#, scope: "user:email,user:follow"


  #provider :google_oauth2, ENV['GOOGLE_KEY'],   ENV['GOOGLE_SECRET']
end