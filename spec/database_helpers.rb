def persisted_data(id:)
  result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE ID = #{id};")
  result.first
end
