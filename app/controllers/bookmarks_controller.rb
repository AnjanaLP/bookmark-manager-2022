class BookmarkManager < Sinatra::Base

  get '/bookmarks' do
    @current_user ||= User.find(id: session[:user_id])
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

  post '/bookmarks' do
    bookmark = Bookmark.create(title: params[:title], url: params[:url])
    if bookmark
      redirect '/bookmarks'
    else
      flash.next[:warning] = "Invalid url submitted"
      redirect '/bookmarks/new'
    end 
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

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end
end
