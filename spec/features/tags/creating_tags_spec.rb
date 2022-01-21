feature 'Creating tags' do
  scenario 'a user can add a tag to a bookmark and see it' do
    bookmark = Bookmark.create(title: "Google", url: "http://www.google.com")

    visit '/bookmarks'
    first('.bookmark').click_button 'Add tag'

    expect(current_path).to eq "/bookmarks/#{bookmark.id}/tags/new"

    fill_in :content, with: "Test tag"
    click_button "Submit tag"

    expect(current_path).to eq '/bookmarks'
    expect(first('.bookmark')).to have_content "Test tag"
  end
end
