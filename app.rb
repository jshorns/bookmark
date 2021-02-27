require 'sinatra/base'
require './lib/bookmark'
require './get_connection.rb'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash


  before do
    @bookmark_list = Bookmark.all
    @tag_list = Tag.all
  end

    get '/' do
      redirect('/bookmarks')
    end

    get '/bookmarks' do
      erb(:'bookmarks/index')
    end

    get '/bookmarks/new' do
      erb(:'bookmarks/new')
    end

    post '/bookmarks' do
      flash[:invalid_url] = "That's not a valid url" unless Bookmark.create(url: params[:url], title: params[:title])
      redirect '/bookmarks'
    end

    delete '/bookmarks/:id' do
      Bookmark.delete(id: params[:id])
      redirect '/bookmarks'
    end

    get '/bookmarks/:id/edit' do
      @bookmark_id = params[:id]
      @bookmark = Bookmark.find(id: @bookmark_id)
      erb(:'bookmarks/edit')
    end

    put '/bookmarks/:id' do
      Bookmark.edit(id: params[:id], url: params[:url], title: params[:title])
      redirect '/bookmarks'
    end

    get '/bookmarks/:id/comments/new' do
      @bookmark_id = params[:id]
      @bookmark = Bookmark.find(id: @bookmark_id)
      erb(:'bookmarks/comments/new')
    end

    post '/bookmarks/:id/comments' do
      DatabaseConnection.db.exec("INSERT INTO comments (text, bookmark_id) VALUES('#{params[:comment]}', '#{params[:id]}');")
      redirect '/bookmarks'
    end

    get '/bookmarks/:id/tags/new' do
      @bookmark_id = params[:id]
      @bookmark = Bookmark.find(id: @bookmark_id)
      erb(:'bookmarks/tags/new')
    end

    post '/bookmarks/:id/tags' do
      @bookmark_id = params[:id]
      @bookmark = Bookmark.find(id: @bookmark_id)
      @content = params[:content]
      @tag = Tag.create(content: params[:content])
      @bookmark.add_tag(tag_id: @tag.id)
      redirect '/bookmarks'
    end

    run! if app_file == $0
end
