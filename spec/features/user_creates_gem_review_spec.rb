require 'spec_helper'

feature 'user creates a gem review', %Q{
  As a registered and logged-in user
  I want to add a review for a gem
  So that I can tell people what I think of that gem
} do 

  # Acceptance Criteria
  # * I have to be signed in to write a review
  # * I can write a review for a specific gem
  # * I can only review a gem once
  # * I can edit my review
  # * I can delete my review

let(:user) {FactoryGirl.create(:user)}

scenario 'user creates a review for a gem' do
  prev_count = Review.count

  user_signs_in(user)
  visit ruby_gems_path
  click_link "Add New Gem"
  fill_in "Name", with: "Devise"
  click_button "Add Gem"
  click_link "Devise"
  click_button "Add Review"
  fill_in "Review", with: "This gem rocks"
  click_button "Save"

  expect(page).to have_content("Review successfully saved")
  expect(Review.count).to eql(prev_count + 1)
end

scenario 'user can only review a gem once' do 
end

scenario 'user can edit their review' do
end

scenario 'user can delete their review' do 
end

def user_signs_in(user)
    visit '/'
    click_link 'Sign In'
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end
end
