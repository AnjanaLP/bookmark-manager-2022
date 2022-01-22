feature 'User sign in' do
  context 'when email and password are both correct' do
    scenario 'a user can sign in and sees a personalised message' do
      User.create(email: 'test@example.com', password: 'password123')

      visit '/sessions/new'
      fill_in(:email, with: 'test@example.com')
      fill_in(:password, with: 'password123')
      click_button('Sign in')

      expect(current_path).to eq '/bookmarks'
      expect(page).to have_content 'Welcome to Bookmark Manager, test@example.com'
    end
  end

  context 'when email is incorrect' do
    scenario 'a user cannot sign in and sees an error message' do
      User.create(email: 'test@example.com', password: 'password123')

      visit '/sessions/new'
      fill_in(:email, with: 'incorrect@example.com')
      fill_in(:password, with: 'password123')
      click_button('Sign in')

      expect(current_path).to eq '/sessions/new'
      expect(page).not_to have_content 'Welcome to Bookmark Manager, test@example.com'
      expect(page).to have_content 'Incorrect email/password'
    end
  end
end
