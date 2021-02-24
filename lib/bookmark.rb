require 'pg'

class Bookmark
  attr_reader :id, :url, :title

  def self.create(url:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect :dbname => 'bookmark_manager_test'
    else
      connection = PG.connect :dbname => 'bookmark_manager'
    end
    result = connection.exec "SELECT * FROM bookmarks"
    result.map { |row| Bookmark.new(id: row['id'], url: row['url'], title: row['title']) }
  end

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

end
