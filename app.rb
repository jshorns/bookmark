require 'sinatra/base'
require './lib/bookmark'
require './get_connection.rb'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash


  before do
    @bookmark_list = Bookmark.all
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

    run! if app_file == $0
end
