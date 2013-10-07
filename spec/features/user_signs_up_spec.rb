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
    attach_file('Avatar', File.join(Rails.root, '/spec/support/stock.jpg'))
    click_button "Sign up"
    expect(User.last.avatar.current_path).to_not be_nil
    expect(page).to have_content("You're in!")
    expect(page).to have_content("Sign Out")
    expect(User.count).to eql(prev_count +1)

  end

  scenario "with invalid info" do
    prev_count = User.count
    visit root_path
    click_link "Sign Up"
    click_button "Sign up"

    expect(page).to have_content("can't be blank")
    expect(User.count).to eql(prev_count)
  end

  scenario "password confirmation does not match password" do
    prev_count = User.count
    visit root_path
    click_link "Sign Up"
    fill_in "Email", with: "user@example.com"
    fill_in("Password", with: '12345678', :match => :prefer_exact)
    fill_in("Password confirmation", with: 'password', :match => :prefer_exact)
    click_button "Sign up"

    expect(page).to have_content("doesn't match")
    expect(page).to have_content("Sign Up")
  end
end


