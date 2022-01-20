feature 'Viewing bookmarks' do
  scenario 'a user can see all the bookmarks' do
    conn = PG.connect( dbname: 'bookmark_manager_test' )

    conn.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")
    conn.exec("INSERT INTO bookmarks (url) VALUES('http://www.bbc.com');")
    conn.exec("INSERT INTO bookmarks (url) VALUES('http://www.cnn.com');")

    visit '/bookmarks'

    expect(page).to have_content "http://www.google.com"
    expect(page).to have_content "http://www.bbc.com"
    expect(page).to have_content "http://www.cnn.com"
  end
end
