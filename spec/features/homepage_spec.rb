feature 'Homepage' do
  scenario 'can see a welcome message' do
    visit '/'
    expect(page).to have_content "Welcome to Bookmark Manager"
  end
end
