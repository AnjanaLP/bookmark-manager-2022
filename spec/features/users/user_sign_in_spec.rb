feature 'User sign in' do

  before { create_user }

  context 'when email and password are both correct' do
    scenario 'a user can sign in and sees a personalised message' do
      visit '/'
      click_button 'Sign in'
      expect(current_path).to eq '/sessions/new'

      sign_in

      expect(current_path).to eq '/bookmarks'
      expect(page).to have_content 'Welcome to Bookmark Manager, test@example.com'
      expect(page).not_to have_button "Sign in"
    end
  end

  context 'when email is incorrect' do
    scenario 'a user cannot sign in and sees an error message' do
      sign_in(email: "incorrect@example.com")

      expect(current_path).to eq '/sessions/new'
      expect(page).not_to have_content 'Welcome to Bookmark Manager, test@example.com'
      expect(page).to have_content 'Incorrect email / password'
    end
  end

  context 'when password is incorrect' do
    scenario 'a user cannot sign in and sees an error message' do
      sign_in(password: "incorrect")

      expect(current_path).to eq '/sessions/new'
      expect(page).not_to have_content 'Welcome to Bookmark Manager, test@example.com'
      expect(page).to have_content 'Incorrect email / password'
    end
  end
end
