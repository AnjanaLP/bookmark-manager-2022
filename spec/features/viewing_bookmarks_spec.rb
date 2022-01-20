feature 'Viewing bookmarks' do
  scenario 'a user can see all the bookmarks' do
    Bookmark.create(title: "Google", url: "http://www.google.com")
    Bookmark.create(title: "BBC", url: "http://www.bbc.com")
    Bookmark.create(title: "CNN", url: "http://www.cnn.com")

    visit '/bookmarks'

    expect(page).to have_link("Google", href: "http://www.google.com")
    expect(page).to have_link("BBC", href: "http://www.bbc.com")
    expect(page).to have_link("CNN", href: "http://www.cnn.com")
  end
end
