feature 'Viewing comments' do
  scenario 'a user can see the correct comments for a bookmark' do
    google_bookmark = Bookmark.create(title: "Google", url: "http://www.google.com")
    bbc_bookmark = Bookmark.create(title: "BBC", url: "http://www.bbc.com")
    google_comment = Comment.create(text: "Google comment", bookmark_id: google_bookmark.id )
    bbc_comment = Comment.create(text: "BBC comment", bookmark_id: bbc_bookmark.id )

    visit '/bookmarks'
    within(first('.bookmark')) do
      expect(page).to have_content "Google comment"
      expect(page).not_to have_content "BBC comment"
    end
  end
end
