feature 'Viewing bookmarks' do
  scenario 'a user can see all the bookmarks' do
    visit '/bookmarks'

    expect(page).to have_content "http://www.google.com"
    expect(page).to have_content "http://www.bbc.com"
    expect(page).to have_content "http://www.cnn.com"
  end
end
