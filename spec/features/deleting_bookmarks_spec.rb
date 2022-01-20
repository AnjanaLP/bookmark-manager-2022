feature 'Deleting bookmarks' do
  scenario 'a user deletes a bookmark and no longer sees it' do
    Bookmark.create(title: "Google", url: "http://www.google.com")
    visit '/bookmarks'
    expect(page).to have_link("Google", href: "http://www.google.com")

    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link("Google", href: "http://www.google.com")
  end
end
