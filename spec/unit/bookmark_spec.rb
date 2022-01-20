require 'bookmark'

describe Bookmark do

  describe '.all' do
    it 'returns all the bookmarks' do
      conn = PG.connect( dbname: 'bookmark_manager_test' )

      conn.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")
      conn.exec("INSERT INTO bookmarks (url) VALUES('http://www.bbc.com');")
      conn.exec("INSERT INTO bookmarks (url) VALUES('http://www.cnn.com');")

      bookmarks = Bookmark.all

      expect(bookmarks).to include("http://www.google.com")
      expect(bookmarks).to include("http://www.bbc.com")
      expect(bookmarks).to include("http://www.cnn.com")
    end
  end
end
