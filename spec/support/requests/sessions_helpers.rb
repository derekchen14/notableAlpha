module Requests
  module SessionHelpers
    
    def sign_up_with(email, password, password_confirmation)
      visit signup_path
      fill_in "Email", with: email
      fill_in "user_password", with: password
      fill_in "user_password_confirmation", with: password_confirmation 
      click_button "Create my account"
    end

    def sign_in_with(email, password)
      visit signin_path
      fill_in "Email", with: email
      fill_in "Password", with: password
      click_button "Sign in"
    end

    def fill_in_with(email, password)
      visit signin_path
      fill_in "Email", with: email
      fill_in "Password", with: password
    end

    def edit_profile_with(username, email, phone_number, password, password_confirmation)
      fill_in :user_name, with: username
      fill_in :email, with: email
      fill_in :phone_number, with: phone_number
      fill_in :password, with: password
      fill_in :password_confirmation, with: password_confirmation

      click_button "Save changes"
    end

  end
end
