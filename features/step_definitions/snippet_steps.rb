
# Background

Given(/^there are users?:$/) do |users_table|
  User.delete_all
  users_table.hashes.each do |user|
    User.create username: user['username'], 
                          email: user['email'], 
                          password: user['password'], 
                          password_confirmation: user['password_confirmation']
  end
end

Given(/^there are snippets?:$/) do |snippets_table|
  Snippet.delete_all
  snippets_table.hashes.each do |snippet|
    Snippet.create name: snippet['name'], content: snippet['content'], user: User.first
  end
end

# Snippets are listed on home page

When(/^I visit the home page$/) do
  visit root_path
end

Then(/^I should see existing snippets$/) do
  expect(page).to have_content(Snippet.first.name) 
  expect(page).to have_content(Snippet.second.name) 
end

# Create new snippet

Given(/^I am logged in$/) do
  @logged_in_user = FactoryGirl.create(:user)
  log_in(@logged_in_user)
  expect(page).to have_content("Logged in: #{@logged_in_user.username}")
end

When(/^I create new snippet$/) do
  @snippet = FactoryGirl.build(:snippet, {name: 'New Snippet', content: 'echo New Snippet'})
  create_snippet(@snippet)
end

Then(/^I should see it on snippets list$/) do
  expect(page).to have_content('Snippet was successfully created.')
  expect(page).to have_content(@snippet.name)
  expect(page).to have_content(@snippet.content)
end

# Edit snippet

# Given(/^I am logged in$/)

When(/^I edit snippet$/) do
  visit root_path
  first(:link, 'Edit').click 
end

Then(/^I should be able to change the snippet$/) do
  @snippet = FactoryGirl.build(:snippet, {name: 'Changed', content: 'echo Changed'})
  update_snipet(@snippet)
end

Then(/^changes should be visible on snippets list$/) do
  expect(page).to have_content('Snippet was successfully updated.')
  expect(page).to have_content(@snippet.name)
  expect(page).to have_content(@snippet.content)
end

# Delete snippet

# Given(/^I am logged in$/)

When(/^I delete snippet$/) do
  visit root_path
  first(:link, 'Remove').click 
end

Then(/^I should not see it on snippets list$/) do
  expect(page).to have_content('Snippet was successfully destroyed.')
end

# Actions are available only to logged in users

Given(/^I am not logged in$/) do
  visit root_path
  expect(page).to have_content('Log in')
end

When(/^I execute action "(.*?)"$/) do |action|
  begin
    first(:link, action).click 
  rescue
    first(:button, action).click
  end
end

Then(/^I should be redirected to Log In page$/) do 
  expect(page).to have_content('You need to sign in or sign up before continuing.')
end

# Execute snippet

# Given(/^I am logged in$/)

When(/^I execute snippet "(.*?)" with "(.*?)"$/) do |name, content|
  visit root_path
  @snippet = FactoryGirl.build(:snippet, {name: name, content: content})
  create_snippet(@snippet)
  click_link name.gsub('\"','')
  click_link 'Execute'
end

Then(/^I should see "(.*?)"$/) do |output|
  expect(page).to have_content('Snippet Details')
  expect(page).to have_content(output) 
end