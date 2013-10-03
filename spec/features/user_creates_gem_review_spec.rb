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

  scenario 'user successfully adds gem review' do
    prev_count = Review.count

    user_signs_in(user)
    new_gem
    user_adds_review

    expect(page).to have_content("Review successfully saved")
    expect(Review.count).to eql(prev_count + 1)
    expect(page).to have_content("Home")
  end
  
  scenario 'user fails to add a gem review' do
    # prev_count = Review.count 

    # user_signs_in(user)
    # new_gem
    # click_button "Add New Review"
    # click_button "Save"
 
    # expect(page).to have_content("can't be blank")
    # expect(page).to have_content("Review successfully saved")
    # expect(Review.count).to eql(prev_count)
  end

  scenario 'user tries to review same gem twice' do 
    # prev_count = Review.count 

    # user_signs_in(user)
    # new_gem
    # user_adds_review
 
    # expect(page).to have_content("You have already reviewed this gem")
    # expect(page).to_not have_content("Review successfully saved")
    # expect(Review.count).to eql(prev_count)
  end

  scenario 'user edits their review' do
  end

  scenario 'non-author fails to edit review' do 
  end

  scenario 'user deletes their review' do 
  end

  scenario 'non-author fails to delete review' do 
  end

  scenario 'user views a list of reviews' do 
  end

  def user_signs_in(user)
    visit '/'
    click_link 'Sign In'
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

  def new_gem
      visit ruby_gems_path
      click_link 'Add New Gem'
      fill_in "Name", with: "Devise"
      click_button "Add Gem"
      click_link "Devise"
  end

  def user_adds_review
    click_button "Add New Review"
    fill_in "Rating", with: 7
    fill_in "Title", with: "Awesome Gem"
    fill_in "Content", with: "This gem rocks"
    click_button "Save"
  end
end
