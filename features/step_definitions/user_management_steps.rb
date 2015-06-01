# Register / sign up

Given(/^I am new user$/) do
end

When(/^I register$/) do
  sign_up('new user', 'newuser@email.com', 'nupassword', 'nupassword')
end

Then(/^I should be logged in$/) do
  expect(page).to have_content('Welcome! You have signed up successfully.') 
  expect(page).to have_content('Logged in: new user') 
end

# Log in/out

Given(/^I am registered$/) do
  @registred_user = FactoryGirl.create(:user)
end

When(/^I log in$/) do
  log_in(@registred_user)
end

Then(/^I should see the log in confirmation$/) do
  expect(page).to have_content('Signed in successfully.') 
  expect(page).to have_content("Logged in: #{@registred_user.username}") 
  expect(page).to have_content('Log out') 
end

When(/^I log out$/) do
  log_out
end

Then(/^I should see the log out confirmation$/) do
  expect(page).to have_content('Signed out successfully.') 
  expect(page).to have_content('Log in') 
  expect(page).to have_content('Sign up') 
end

