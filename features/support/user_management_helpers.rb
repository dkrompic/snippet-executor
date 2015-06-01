module Features
  module UserManagementHelpers
    def sign_up(username, email, password, confirmation)
      visit new_user_registration_path
      fill_in 'Username', with: username
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', :with => confirmation
      click_button 'Sign up'
    end

    def log_in(user)
      visit new_user_session_path
      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    def log_out
      click_link 'Log out'
    end
  end
end

World(Features::UserManagementHelpers)