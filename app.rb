require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require './lib/bookmark'
require './lib/bookmark_tag'
require './lib/user'
require './database_connection_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  configure :development do
    register Sinatra::Reloader
  end

  get '/bookmarks' do
    @current_user = User.find(id: session[:user_id])
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :'bookmarks/edit'
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb :'comments/new'
  end

  get '/bookmarks/:id/tags/new' do
    @bookmark_id = params[:id]
    erb :'tags/new'
  end

  get '/tags/:id/bookmarks' do
    @tag = Tag.find(id: params[:id])
    erb :'tags/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/bookmarks' do
    flash.next[:error] = "Invalid url submitted" unless Bookmark.create(title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(text: params[:text], bookmark_id: params[:id])
    redirect '/bookmarks'
  end

  post '/bookmarks/:id/tags' do
    tag = Tag.create(content: params[:content])
    BookmarkTag.create(bookmark_id: params[:id], tag_id: tag.id)
    redirect '/bookmarks'
  end

  post '/users' do
    user = User.create(email: params[:email], password: params[:passord])
    session[:user_id] = user.id
    redirect '/bookmarks'
  end

  post '/sessions' do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect '/bookmarks'
    else
      flash.next[:error] = "Incorrect email/password"
      redirect '/sessions/new'
    end 
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
