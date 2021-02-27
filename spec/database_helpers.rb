def persisted_data(id:)
  result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE ID = #{id};")
  result.first
end

def persisted_data_comment(id:)
  result = DatabaseConnection.query("SELECT * FROM comments WHERE ID = #{id};")
  result.first
end

def persisted_data_tag(id:)
  result = DatabaseConnection.query("SELECT * FROM tags WHERE ID = #{id};")
  result.first
end
