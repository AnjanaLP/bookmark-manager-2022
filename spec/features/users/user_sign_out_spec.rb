feature 'User sign out' do
  scenario 'a signed in user can sign out' do
    create_user
    
    visit '/'
    expect(page).not_to have_button 'Sign out'

    sign_in
    expect(page).to have_content 'Welcome to Bookmark Manager, test@example.com'
    expect(page).to have_button 'Sign out'

    click_button 'Sign out'
    expect(page).not_to have_content 'Welcome to Bookmark Manager, test@example.com'
    expect(page).to have_content "Successfully signed out"
  end
end
