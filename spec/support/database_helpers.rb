def persisted_data(table:, id:)
  result = DatabaseConnection.query("SELECT * FROM #{table} WHERE id = #{id};")
  result.first
end
