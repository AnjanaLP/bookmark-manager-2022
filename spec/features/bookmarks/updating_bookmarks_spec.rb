feature 'Updating bookmarks' do
  scenario 'a user can edit a bookmark and see it updated' do
    bookmark = Bookmark.create(title: "Google", url: "http://www.google.com")
    visit '/bookmarks'
    expect(page).to have_link("Google", href: "http://www.google.com")

    first('.bookmark').click_button 'Edit'

    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"
    fill_in :title, with: "Updated Bookmark"
    fill_in :url, with: "http://www.updated-bookmark.com"
    click_button "Update bookmark"

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link("Google", href: "http://www.google.com")
    expect(page).to have_link("Updated Bookmark", href: "http://www.updated-bookmark.com")
  end
end
