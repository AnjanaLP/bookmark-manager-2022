feature 'Creating bookmarks' do
  scenario 'a user can add a bookmark and see it' do
    visit '/bookmarks'
    expect(page).not_to have_content "http://www.new-bookmark.com"

    click_button "Add a bookmark"
    expect(current_path).to eq '/bookmarks/new'

    fill_in :title, with: "New Bookmark"
    fill_in :url, with: "http://www.new-bookmark.com"
    click_button "Submit"

    expect(current_path).to eq '/bookmarks'
    expect(page).to have_link("New Bookmark", href: "http://www.new-bookmark.com")
  end

  scenario 'a user cannot add an invalid bookmark and sees an error message' do
    visit 'bookmarks/new'
    fill_in :title, with: "Invalid"
    fill_in :url, with: "invalid"
    click_button "Submit"

    expect(current_path).to eq '/bookmarks/new'
    expect(page).not_to have_link("Invalid", href: "invalid")
    expect(page).to have_content "Invalid url submitted"
  end
end
