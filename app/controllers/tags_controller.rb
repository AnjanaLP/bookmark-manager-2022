class BookmarkManager < Sinatra::Base

  get '/tags/:id/bookmarks' do
    @tag = Tag.find(id: params[:id])
    erb :'tags/index'
  end
end 
