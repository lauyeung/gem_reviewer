require 'spec_helper'

feature "User edits their review", %Q{
  As an author of a review
  I want to be able to edit my review
  } do

# Acceptance Criteria
# * Only the author of a review can edit a review
# * non-authors will not see a link to edit

  # let(:review) { FactoryGirl.create(:review) }
  # let(:ruby_gem) { review.ruby_gem }
  # let(:user) { review.user }

  scenario "author successfully edits review" do
    review = FactoryGirl.create(:review)
    ruby_gem = review.ruby_gem
    user = review.user
    user_signs_in(user)
    visit ruby_gem_path(ruby_gem)
    expect(page).to have_content(review.content)
    fill_in "Title", with: "Terrible"
    fill_in "Content", with: "Love this gem"
    select 10, from: "Rating"
    click_button "Update"
    save_and_open_page
    expect(page).to have_content("Love this gem")
  end

  scenario "author fails to edit review" do
    review = FactoryGirl.create(:review)
    ruby_gem = review.ruby_gem
    user = review.user
    user_signs_in(user)
    visit ruby_gem_path(ruby_gem)
    expect(page).to have_content(review.content)
    fill_in "Content", with: ""
    click_button "Update"
    expect(review.content).to_not eql("")
  end

  scenario "non-author can not update a review" do
    review = FactoryGirl.create(:review)
    user = FactoryGirl.create(:user)
    ruby_gem = review.ruby_gem
    user_signs_in(user)
    visit ruby_gem_path(ruby_gem)
    expect(page).to_not have_selector(:link_or_button, 'Update')

  end
end
