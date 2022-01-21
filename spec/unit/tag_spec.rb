require 'tag'

describe Tag do
  let(:bookmark_class)    { double :bookmark_class }

  describe '.create' do
    context 'when the tag does not already exist' do
      it 'adds a new tag' do
        tag = Tag.create(content: "Test tag")
        persisted_data = persisted_data(table: 'tags', id: tag.id)

        expect(tag).to be_a Tag
        expect(tag.id).to eq persisted_data['id']
        expect(tag.content).to eq "Test tag"
      end
    end

    context 'when the tag does already exist' do
      it 'returns the existing tag' do
        tag_1 = Tag.create(content: "Test tag")
        tag_2 = Tag.create(content: "Test tag")
        expect(tag_2.id).to eq tag_1.id
      end
    end
  end

  describe '.where' do
    it 'retrieves the tags for the given bookmark' do
      bookmark = Bookmark.create(url: "http://www.test.com", title: "Test Bookmark")
      tag_1 = Tag.create(content: 'Test tag 1')
      tag_2 = Tag.create(content: 'Test tag 2')
      BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag_1.id)
      BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag_2.id)

      tags = Tag.where(bookmark_id: bookmark.id)
      tag = tags.first

      expect(tags.length).to eq 2
      expect(tag).to be_a Tag
      expect(tag.id).to eq tag_1.id
      expect(tag.content).to eq 'Test tag 1'
    end
  end

  describe '.find' do
    it 'retrieves the tag with the given id' do
     tag = Tag.create(content: 'Test tag')
     returned_tag = Tag.find(id: tag.id)

     expect(returned_tag).to be_a Tag
     expect(returned_tag.id).to eq tag.id
     expect(returned_tag.content).to eq 'Test tag'
    end
  end

  describe '#bookmarks' do
    it 'calls .where on the Bookmark class' do
      tag = Tag.create(content: 'Test tag')
      expect(bookmark_class).to receive(:where).with(tag_id: tag.id)
      tag.bookmarks(bookmark_class)
    end
  end
end
