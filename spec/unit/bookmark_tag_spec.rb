require 'bookmark_tag'

describe BookmarkTag do
  describe '.create' do
    it 'adds a new bookmark tag' do
      bookmark = Bookmark.create(title: "Google", url: "http://www.google.com")
      tag = Tag.create(content: "Test tag")
      bookmark_tag = BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag.id)


      expect(bookmark_tag).to be_a BookmarkTag
      expect(bookmark_tag.bookmark_id).to eq bookmark.id
      expect(bookmark_tag.tag_id).to eq tag.id
    end
  end
end
