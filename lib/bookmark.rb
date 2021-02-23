require 'pg'

class Bookmark
  attr_reader :text

  def self.all
    con = PG.connect :dbname => 'bookmark_manager'
    rs = con.exec "SELECT * FROM bookmarks"
    rs.map { |row| row['url'] }
  end

  def initialize(text)
    @text = text
  end

end
