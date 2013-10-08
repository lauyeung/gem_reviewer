require 'spec_helper'

feature "signing in", %Q{
  As a signed up user
  I want to sign back in
  so that I can use the site
} do
 # Acceptance Criteria

 # * User must enter email and password
 # * Upon completion they are successfully logged in
 # * If invalid email or password is given user is presented with errors

  scenario "user signs in" do
    user = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in "Login", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    expect(page).to have_content("You're In!")
    expect(page).to have_content("Sign Out")
  end

  scenario ' a nonexistent email and password is supplied' do
    visit new_user_session_path
    click_button "Sign In"

    expect(page).to have_content("Invalid email or password.")
    expect(page).to_not have_content("Sign Out")
    expect(page).to_not have_content("You're In!")
  end

  scenario 'a existing email with the wrong password is denied access ' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Login", with: user.email
    fill_in 'Password', with: 'incorrectpassword'
    click_button "Sign In"

    expect(page).to have_content("Invalid email or password.")
    expect(page).to_not have_content("Sign Out")
    expect(page).to_not have_content("You're In!")
  end

  scenario "an already authenticated user cannot re-sign in" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Login", with: user.email
    fill_in 'Password', with: user.password
    click_button "Sign In"

    expect(page).to have_content("Sign Out")
    expect(page).to_not have_content("Sign In")
  end
end
