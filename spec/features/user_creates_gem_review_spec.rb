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
let(:ruby_gem) {FactoryGirl.create(:ruby_gem)}

  scenario 'user navigates to a specific gem' do
    # prev_count = Review.count
    gem_to_review = ruby_gem

    user_signs_in(user)
    visit ruby_gems_path
    click_link gem_to_review.name
    expect(page).to have_content('Add New Gem Review')

    # expect(page).to have_content("Review successfully saved")
    # expect(Review.count).to eql(prev_count + 1)
    # expect(page).to have_content("Home")
  end

  scenario 'user adds a review to a gem' do
    gem_to_review = ruby_gem

    user_signs_in(user)
    visit ruby_gems_path
    click_link gem_to_review.name

    prev_count = ruby_gem.reviews.count
    fill_in "Title", with: "Awesome gem"
    fill_in "Content", with: "Love this gem"
    select 10, from: "Rating"

    click_button "Save"

    expect(page).to have_content("Review successfully saved")
    expect(ruby_gem.reviews.count).to eql(prev_count + 1)
  end

  scenario 'user fails to add a gem review' do
    gem_to_review = ruby_gem

    user_signs_in(user)
    visit ruby_gems_path
    click_link gem_to_review.name

    prev_count = ruby_gem.reviews.count

    click_button "Save"
    expect(page).to have_content("can't be blank")
    expect(ruby_gem.reviews.count).to eql(prev_count)
  end

  scenario 'user tries to review same gem twice' do
    gem_to_review = ruby_gem

    user_signs_in(user)
    visit ruby_gems_path
    click_link gem_to_review.name
    fill_in "Title", with: "Sweet"
    fill_in "Content", with: "Love this gem"
    select 8, from: "Rating"

    click_button "Save"

    expect(page).to_not have_content("Title")
    expect(page).to_not have_content("Content")
    expect(page).to_not have_content("Rating")
  end

  scenario "non-authenticated user cannot review a gem" do
    gem_to_review = ruby_gem
    visit ruby_gems_path
    click_link gem_to_review.name
    save_and_open_page

    expect(page).to_not have_content("Title")
    expect(page).to_not have_content("Content")
    expect(page).to_not have_content("Rating")
  end

  def user_signs_in(user)
    visit '/'
    click_link 'Sign In'
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end
end
