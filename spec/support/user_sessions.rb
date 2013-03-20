def login_user(email, password)
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  click_button "Sign in"
end