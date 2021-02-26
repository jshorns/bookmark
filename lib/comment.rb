class Comment
  attr_reader :id, :text, :bookmark_id

  def self.create(text:, bookmark_id:)
    result = DatabaseConnection.query("INSERT INTO comments (text, bookmark_id) VALUES('#{text}', '#{bookmark_id}') RETURNING id, text, bookmark_id;")
    Comment.new(id: result[0]['id'], text: result[0]['text'], bookmark_id: result[0]['bookmark_id'])
  end

  def self.all(bookmark_id:)
    result = DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id = #{bookmark_id}")
    result.map { |row| Comment.new(id: row['id'], text: row['text'], bookmark_id: row['bookmark_id']) }
  end

  def initialize(id:, text:, bookmark_id:)
    @id = id
    @text = text
    @bookmark_id = bookmark_id
  end
end
