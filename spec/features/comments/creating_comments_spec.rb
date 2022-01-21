feature 'Creating comments' do
  scenario 'a user can add a comment to a bookmark and see it' do
    bookmark = Bookmark.create(title: "Google", url: "http://www.google.com")

    visit '/bookmarks'
    first('.bookmark').click_button 'Add comment'

    expect(current_path).to eq "/bookmarks/#{bookmark.id}/comments/new"

    fill_in :text, with: "Test comment"
    click_button "Submit comment"

    expect(current_path).to eq '/bookmarks'
    expect(first('.bookmark')).to have_content "Test comment"
  end
end
