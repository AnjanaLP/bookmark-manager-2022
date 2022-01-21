require 'comment'

describe Comment do
  describe '.create' do
    it 'adds a new comment' do
      bookmark = Bookmark.create(title: "Google", url: "http://google.com")
      comment = Comment.create(text: "Test comment", bookmark_id: bookmark.id)
      persisted_data = persisted_data(table: "comments", id: comment.id)

      expect(comment).to be_a Comment
      expect(comment.id).to eq persisted_data['id']
      expect(comment.text).to eq "Test comment"
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end

  describe '.where' do
    it 'returns the persisted comments for the given bookmark' do
      bookmark = Bookmark.create(title: "Google", url: "http://google.com")
      Comment.create(text: "First test comment", bookmark_id: bookmark.id)
      Comment.create(text: "Second test comment", bookmark_id: bookmark.id)

      comments = Comment.where(bookmark_id: bookmark.id)
      comment = comments.first
      persisted_data = persisted_data(table: 'comments', id: comment.id)

      expect(comments.length).to eq 2
      expect(comment.id).to eq persisted_data['id']
      expect(comment.text).to eq "First test comment"
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end
end
