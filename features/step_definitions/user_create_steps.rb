When(/^I go to the join page$/) do
  visit "/join"
end

When(/^sign up as a new user$/) do
  within "#signup" do
    fill_in :full_name, with: 'Some Person'
    fill_in :email, with: 'someemail@email.com'
    fill_in :password, with: 'secret'
    fill_in :password_confirmation, with: 'secret'
    click_on "Sign up"
  end
end

Then(/^there should be a new user in the database$/) do
  expect(User.first).to_not eq nil
end

Then(/^I should be redirected to the login page$/) do
  expect(page.current_path).to eq "/#/login"
end