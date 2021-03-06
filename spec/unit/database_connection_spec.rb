require './app/models/database_connection'

describe DatabaseConnection do

  describe '.setup' do
    it 'sets up the connection to the given database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'bookmark_manager_test')
      DatabaseConnection.setup('bookmark_manager_test')
    end
  end

  describe '.query' do
    it 'executes the given query on the database through PG' do
      connection = DatabaseConnection.setup('bookmark_manager_test')
      expect(connection).to receive(:exec_params).with("SELECT * FROM bookmarks;", [])
      DatabaseConnection.query("SELECT * FROM bookmarks;")
    end
  end
end
