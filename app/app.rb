require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'

require_relative 'controllers/application_controller'
require_relative 'controllers/bookmarks_controller'
require_relative 'controllers/sessions_controller'
require_relative 'controllers/tags_controller'
require_relative 'controllers/users_controller'

require_relative 'models/bookmark'
require_relative 'models/bookmark_tag'
require_relative 'models/user'
require_relative 'database_connection_setup'
