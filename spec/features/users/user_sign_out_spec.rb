feature 'User sign out' do
  scenario 'a signed in user can sign out' do
    User.create(email: 'test@example.com', password: 'password123')

    visit '/sessions/new'
    fill_in(:email, with: 'test@example.com')
    fill_in(:password, with: 'password123')
    click_button('Sign in')
    expect(page).to have_content 'Welcome to Bookmark Manager, test@example.com'

    click_button('Sign out')
    expect(page).not_to have_content 'Welcome to Bookmark Manager, test@example.com'
    expect(page).to have_content "Successfully signed out"
  end
end
