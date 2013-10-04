require 'spec_helper'

feature 'user creates a comment for a gem review', %Q{
  As a registered and logged-in user
  I want to comment on a gem review
  So that I can have discourse on someone's review
} do

  let(:user) { FactoryGirl.create(:user) }
  let(:review) { FactoryGirl.create(:review) }
  let(:ruby_gem) { review.ruby_gem }

  scenario "user adds a comment" do
    user_signs_in(user)
    visit ruby_gem_path(ruby_gem)
    fill_in "comment_content", with: "I agree with this review!"
    click_button "Save Comment"
    expect(page).to have_content("Comment saved!")
  end


  scenario "unauthorized user cannot add a comment" do
  end

end
