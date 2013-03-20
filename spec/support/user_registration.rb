def sign_up_user(user, password)
  visit new_user_registration_path
  fill_in "Email", with: user.email
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password
  click_button "Sign up"
end