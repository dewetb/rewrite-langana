module Features
  module SessionHelpers
    def sign_up_with(role, firstname, lastname, email, password, confirmation)
      visit new_user_registration_path
      choose 'user_role_worker'
      fill_in 'user_firstname', with: firstname
      fill_in 'user_lastname', with: lastname
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', :with => confirmation
      click_button 'Sign up'
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end
  end
end
