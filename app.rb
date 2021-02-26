require 'sinatra/base'
require './lib/bookmark'
require './get_connection.rb'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override

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
      session[:fake] = true if ((/^http:\/\//) || (/^https:\/\//)).match(params[:url]).nil?
      Bookmark.create(url: params[:url], title: params[:title]) unless session[:fake]
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
