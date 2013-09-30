require 'spec_helper'

feature "User signs up", %Q{

As an unauthorized user
I want to sign up
So I may enter my votes and reviews for gems
} do


    # Acceptance Criteria
    # There will be a place for the user to sign up
    # System must validate email and password
    # Username must be in email address format
    # Password must be 8 characters
    # System must show error if the username and password is entered wrong
    # If user name and password are correct the user is saved to the database

    scenario " With valid information" do
      prev_count = User.count
      visit root_path
      click_link "Sign Up"
      fill_in "Email", with: "user@example.com"
      fill_in("Password", with: '12345678', :match => :prefer_exact)
      fill_in("Password confirmation", with: '12345678', :match => :prefer_exact)
      click_button "Sign up"

      expect(page).to have_content("You're in!")
      expect(page).to have_content("Sign Out")
      expect(User.count).to eql(prev_count +1)

    end
  end


