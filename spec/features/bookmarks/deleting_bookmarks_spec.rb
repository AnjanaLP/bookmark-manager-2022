feature 'Deleting bookmarks' do
  scenario 'a user deletes a bookmark and no longer sees it' do
    Bookmark.create(title: "Google", url: "http://www.google.com")
    visit '/bookmarks'
    expect(page).to have_link("Google", href: "http://www.google.com")

    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link("Google", href: "http://www.google.com")
  end

  scenario 'a user can delete a bookmark with comments' do
    bookmark = Bookmark.create(title: "Google", url: "http://www.google.com")
    Comment.create(text: "Google comment", bookmark_id: bookmark.id )

    visit '/bookmarks'
    within(first('.bookmark')) do
      expect(page).to have_link("Google", href: "http://www.google.com")
      expect(page).to have_content "Google comment"
    end

    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link("Google", href: "http://www.google.com")
    expect(page).not_to have_content "Google comment"
  end

  scenario 'a user can delete a bookmark with tags' do
    bookmark = Bookmark.create(title: "Google", url: "http://www.google.com")
    tag = Tag.create(content: "Google tag")
    BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag.id)

    visit '/bookmarks'
    within(first('.bookmark')) do
      expect(page).to have_link("Google", href: "http://www.google.com")
      expect(page).to have_content "Google tag"
    end

    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link("Google", href: "http://www.google.com")
    expect(page).not_to have_content "Google tag"
  end
end
