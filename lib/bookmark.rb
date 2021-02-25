require 'pg'

class Bookmark
  attr_reader :id, :url, :title

  def self.create(url:, title:)
    result = get_connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
  end

  def self.all
    result = get_connection.exec "SELECT * FROM bookmarks"
    result.map { |row| Bookmark.new(id: row['id'], url: row['url'], title: row['title']) }
  end

  def self.delete(id:)
    get_connection.exec("DELETE FROM bookmarks WHERE id = '#{id}'")
  end

  def self.edit(id:, url:, title:)
    get_connection.exec("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = '#{id}'")
  end

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  private

  def self.get_connection
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
  end

end
