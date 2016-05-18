set :stage, :production
set :branch, "master"
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

# This is used in the Nginx VirtualHost to specify which domains
# the app should appear on. If you don't yet have DNS setup, you'll
# need to create entries in your local Hosts file for testing.
set :server_name, '~^(www\\.)?\\.10g-force\\.com$'

server '52.37.52.240', user: 'ubuntu', roles: %w{web app db}, primary: true

set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:full_app_name)}"

# dont try and infer something as important as environment from
# stage name.
set :rails_env, :production

# used in case we're deploying multiple versions of the same
# app side by side. Also provides quick sanity checks when looking
# at filepaths

# number of unicorn workers, this will be reflected in
# the unicorn.rb and the monit configs
set :unicorn_worker_count, 4

# whether we're using ssl or not, used for building nginx
# config file
set :enable_ssl, false

set :pem_key, "../pem_keys/10GKEY.pem"

# Server pem-key authentication
set :ssh_options, {
  forward_agent: true,
  auth_methods:  ["publickey"],
  keys:          [fetch(:pem_key)]
}
