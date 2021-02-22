class Bookmark
  attr_reader :text

  def self.all
    [Bookmark.new("hello").text, Bookmark.new("hi").text, Bookmark.new("what's up").text]
  end

  def initialize(text)
    @text = text
  end

end
