class BookmarkManager < Sinatra::Base

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect '/bookmarks'
    else
      flash.next[:warning] = "Incorrect email / password"
      redirect '/sessions/new'
    end
  end

  post '/sessions/destroy' do
    session.clear
    flash.next[:notice] = "Successfully signed out"
    redirect '/bookmarks'
  end
end
