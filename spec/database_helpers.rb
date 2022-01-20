require 'pg'

def persisted_data(id:)
  conn = PG.connect(dbname: 'bookmark_manager_test')
  result = conn.exec("SELECT * FROM bookmarks WHERE id = #{id};")
  result.first
end
