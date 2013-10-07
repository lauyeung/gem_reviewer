require 'spec_helper'

feature "user votes review up or down", %Q{
  As a registered and logged-in user
  I want to upvote/downvote reviews
  So that I can indicate which reviews I like/dislike
  } do

  # Acceptance Criteria
  # * I can upvote or downvote a review
  # * Once I have voted, I will be able to see my vote
  # * I can only vote on each review once

  let(:user) {FactoryGirl.create(:user)}

  scenario 'authenticated user can upvote a review' do
    review = FactoryGirl.create(:review)
    ruby_gem = review.ruby_gem
    prev_count = Vote.count

    user_signs_in(user)
    visit ruby_gems_path
    click_link ruby_gem.name

    click_button('.icon-thumbs-up')
    save_and_open_page
    expect(ruby_gem.reviews.first.votes.count).to eql(1)
    expect(Vote.count).to eql(prev_count + 1)
    expect(page).to have_content("Thank you for voting")
  end

  scenario 'authenticated user can downvote a review' do
  end

  scenario 'authenticated user can see total votes for a review' do
  end

  scenario 'users fails to vote twice on the same review' do
  end

 def user_signs_in(user)
    visit '/'
    click_link 'Sign In'
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end
end
