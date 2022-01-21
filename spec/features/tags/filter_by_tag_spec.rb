feature 'Filter by tag' do
  scenario 'a user can see all bookmarks with the same tag' do
  Bookmark.create(title: "First Bookmark", url: "http://www.first.com")
  Bookmark.create(title: "Second Bookmark", url: "http://www.second.com")
  Bookmark.create(title: "Third Bookmark", url: "http://www.third.com")

  visit '/bookmarks'

  within page.find('.bookmark:nth-of-type(1)') do
    click_button 'Add tag'
  end
  fill_in :content, with: 'Test tag'
  click_button 'Submit'

  within page.find('.bookmark:nth-of-type(2)') do
    click_button 'Add tag'
  end
  fill_in :content, with: 'Test tag'
  click_button 'Submit'

  first('.bookmark').click_link 'Test tag'

  expect(page).to have_link 'First Bookmark', href: 'http://www.first.com'
  expect(page).to have_link 'Second Bookmark',  href: 'http://www.second.com'
  expect(page).not_to have_link 'Third Bookmark', href: 'http://www.third.com'
  end
end
