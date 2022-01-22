def create_user
   User.create(email: 'test@example.com', password: 'password123')
end

def sign_in(email: 'test@example.com' , password: "password123")
  visit '/sessions/new'
  fill_in :email, with: email
  fill_in :password, with: password
  click_button "Submit"
end
