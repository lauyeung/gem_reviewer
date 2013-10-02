require 'spec_helper'

feature 'user signs out of account', %Q{
  As an authenticated user
  I want to sign out
  So I can protect my account from other individuals
} do 

  # Acceptance Citeria
  # * The page confirms that I've logged out
  # * I have access to log back in

  scenario 'user signs out of account' do 
    user = FactoryGirl.create(:user)

    visit user_session_path
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "Sign Out"

    expect(page).to have_content("Signed out successfully")
    expect(page).to have_content("Sign In")
  end
end