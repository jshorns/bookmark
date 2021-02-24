require 'pg'

class Bookmark
  attr_reader :text

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect :dbname => 'bookmark_manager_test'
    else
      connection = PG.connect :dbname => 'bookmark_manager'
    end
    result = connection.exec "SELECT * FROM bookmarks"
    result.map { |row| row['url'] }
  end

  def initialize(text)
    @text = text
  end

end
