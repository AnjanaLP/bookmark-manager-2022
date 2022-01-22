feature 'User sign up' do
  scenario 'a user can sign up and sees a personalised message' do
    visit '/'
    expect(page).to have_content "Welcome to Bookmark Manager"
    expect(page).to have_button "Sign up"

    click_button "Sign up"
    expect(current_path).to eq '/users/new'

    fill_in :email, with: "test@example.com"
    fill_in :password, with: "password123"
    click_button "Submit"

    expect(current_path).to eq '/bookmarks'
    expect(page).to have_content "Welcome to Bookmark Manager, test@example.com"
    expect(page).not_to have_button "Sign up"
  end
end
