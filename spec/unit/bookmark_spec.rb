require 'bookmark'

describe Bookmark do

  describe '.all' do
    it 'returns all the bookmarks' do
      bookmark = Bookmark.create(title: "Google", url: "http://www.google.com")
      Bookmark.create(title: "BBC", url: "http://www.bbc.com")
      Bookmark.create(title: "CNN", url: "http://www.cnn.com")

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq "Google"
      expect(bookmarks.first.url).to eq "http://www.google.com"
    end
  end

  describe '.create' do
    it 'adds a new bookmark' do
      bookmark = bookmark = Bookmark.create(title: "New Bookmark", url: "http://www.new-bookmark.com")
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq "New Bookmark"
      expect(bookmark.url).to eq "http://www.new-bookmark.com"
    end
  end
end
