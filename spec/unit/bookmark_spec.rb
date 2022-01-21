require 'bookmark'

describe Bookmark do
  let(:comment_class)   { double :comment_class }

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
      bookmark = Bookmark.create(title: "New Bookmark", url: "http://www.new-bookmark.com")
      persisted_data = persisted_data(table: 'bookmarks', id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq "New Bookmark"
      expect(bookmark.url).to eq "http://www.new-bookmark.com"
    end

    context 'when the url is invalid' do
      it 'does not add the bookmark' do
        Bookmark.create(title: "Invalid Bookmark", url: "invalid-bookmark")
        expect(Bookmark.all).to be_empty
      end

      it 'returns false' do
        expect(Bookmark.create(title: "Invalid Bookmark", url: "invalid-bookmark")).to be false
      end
    end
  end

  describe '.delete' do
    it 'deletes the bookmark with the given id' do
      bookmark = Bookmark.create(title: "Google", url: "http://www.google.com")

      Bookmark.delete(id: bookmark.id)

      expect(Bookmark.all.length).to eq 0
    end
  end

  describe '.find' do
    it 'returns the bookmark with the given id' do
      bookmark = Bookmark.create(title: "Google", url: "http://www.google.com")
      retrieved_bookmark = Bookmark.find(id: bookmark.id)

      expect(retrieved_bookmark).to be_a Bookmark
      expect(retrieved_bookmark.id).to eq bookmark.id
      expect(retrieved_bookmark.title).to eq bookmark.title
      expect(retrieved_bookmark.url).to eq bookmark.url
    end
  end

  describe '.update' do
    it 'updates the bookmark with the given data' do
      bookmark = Bookmark.create(title: "Google", url: "http://www.google.com")
      updated_bookmark = Bookmark.update(id: bookmark.id, title: "Updated Bookmark", url: "http://www.updated-bookmark.com")

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq "Updated Bookmark"
      expect(updated_bookmark.url).to eq "http://www.updated-bookmark.com"
    end
  end

  describe '#comments' do
    it 'calls the .where method on the Comment class' do
      bookmark = Bookmark.create(title: "Google", url: "http://www.google.com")

      expect(comment_class).to receive(:where).with(bookmark_id: bookmark.id)
      bookmark.comments(comment_class)
    end
  end
end
