require 'spec_helper'

feature "User deletes their review", %Q{
  As an author of a review
  I want to be able to delete my review
  so that I can be in control of my content
} do

# Acceptance Criteria
# * Only the author of a review can delete a review
# * non-authors will not see a link to delete

  scenario "authenticated user deletes review" do
    new_review = FactoryGirl.create(:review)
    title = new_review.title
    ruby_gem = new_review.ruby_gem
    user = new_review.user
    prev_count = Review.count
    user_signs_in(user)
    visit ruby_gem_path(ruby_gem)
    click_link "Delete"
    expect(Review.count).to eql(prev_count - 1)
  end

  scenario "non-reviewer can not delete review" do
    new_review = FactoryGirl.create(:review)
    user = FactoryGirl.create(:user)
    ruby_gem = new_review.ruby_gem
    user_signs_in(user)
    visit ruby_gem_path(ruby_gem)

    expect(page).to_not have_content("Delete")

  end
end



