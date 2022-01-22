class BookmarkManager < Sinatra::Base
  set :root, File.dirname(File.expand_path('..', __FILE__))
  enable :sessions, :method_override
  register Sinatra::Flash
  register Sinatra::Partial
  set :partial_template_engine, :erb
  enable :partial_underscores

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
