require 'pg'
require_relative 'database_connection'

class Tag
  attr_reader :id, :content

  def self.create(content:)
    return false if exists?(content)
    result = DatabaseConnection.query("INSERT INTO tags (content) VALUES('#{content}') RETURNING id, content")
    Tag.new(id: result[0]['id'], content: result[0]['content'])
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM tags")
    result.map { |row| Tag.new(id: row['id'], content: row['content']) }
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM tags WHERE id = '#{id}'")
    Tag.new(id: result[0]['id'], content: result[0]['content'])
  end

  def initialize(id:, content:)
    @id = id
    @content = content
  end

  private

  def self.exists?(content)
    result = DatabaseConnection.query("SELECT * FROM tags WHERE content = '#{content}'")
    return true if result.cmd_tuples != 0
  end

end
