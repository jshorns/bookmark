require_relative 'database_connection'
require_relative 'comment'
require_relative 'tag'

class Bookmark
  attr_reader :id, :url, :title, :comments

  def self.create(url:, title:)
    return false unless is_url?(url)
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks")
    result.map { |row| Bookmark.new(id: row['id'], url: row['url'], title: row['title']) }
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = '#{id}'")
  end

  def self.edit(id:, url:, title:)
    result = DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = '#{id}' RETURNING id, url, title;")
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = '#{id}'")
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
  end

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def comments
    Comment.all(bookmark_id: @id)
  end

  def tags(bookmark_id: @id)
    result = DatabaseConnection.query("SELECT content FROM tags INNER JOIN bookmark_tags ON tags.id = bookmark_tags.tag_id WHERE bookmark_id = '#{@id}';")
    tags = result.map { |row| Tag.new(id: row['id'], content: row['content']) }
  end

  def add_tag(tag_id:)
    DatabaseConnection.query("INSERT INTO bookmark_tags (bookmark_id, tag_id) VALUES('#{@id}', '#{tag_id}');")
  end

  private

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

end
