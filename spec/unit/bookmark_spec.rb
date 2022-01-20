require 'bookmark'

describe Bookmark do

  describe '.all' do
    it 'returns all the bookmarks' do
      bookmarks = Bookmark.all

      expect(bookmarks).to include("http://www.google.com")
      expect(bookmarks).to include("http://www.bbc.com")
      expect(bookmarks).to include("http://www.cnn.com")
    end
  end
end
