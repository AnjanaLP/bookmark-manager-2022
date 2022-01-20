feature 'Creating bookmarks' do
  scenario 'a user can add a bookmark and see it' do
    visit '/bookmarks'
    expect(page).not_to have_content "http://www.new-bookmark.com"

    click_link "Add bookmark"
    expect(current_path).to eq '/bookmarks/new'

    fill_in :title, with: "New Bookmark"
    fill_in :url, with: "http://www.new-bookmark.com"
    click_button "Add bookmark"

    expect(page).to have_link("New Bookmark", href: "http://www.new-bookmark.com")
  end
end
