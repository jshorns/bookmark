require 'sinatra/base'
require './lib/bookmark.rb'

class BookmarkManager < Sinatra::Base
  before do
    @bookmark_list = Bookmark.all
  end

    get '/' do
        erb :index
    end

    get '/bookmarks' do
      erb :bookmarks
    end

    run! if app_file == $0
end
