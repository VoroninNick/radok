# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Includes migrations handling
require 'capistrano/rails/migrations'

# Load gem's cap classes
require 'capistrano/bundler'

# Load rvm cap classes
require 'capistrano/rvm'

# Includes asset handling
require 'capistrano/rails/assets'

# Rails console
require 'capistrano/rails/console'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
Dir.glob('lib/capistrano/**/*.rb').each { |r| import r }
