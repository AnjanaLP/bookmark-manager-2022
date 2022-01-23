require 'pg'

class DatabaseConnection

  def self.setup(dbname = nil)
    @connection = PG.connect( dbname: dbname )
  end

  def self.query(sql_query, params = [])
    @connection.exec_params(sql_query, params)
  end
end
