class BookmarkManager < Sinatra::Base
  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect '/bookmarks'
  end
end
