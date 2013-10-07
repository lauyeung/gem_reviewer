require 'spec_helper'

feature 'a user can only vote on a review once', %Q{
  As a registered and logged-in user
  I want to upvote/downvote reviews
  So that I can indicate which reviews I like/dislike
} do 

  # Acceptance Criteria
  # * I can upvote or downvote a reviews
  # * I can only vote on each review once
  # * Once I have voted, I will be able to see what my vote was
  # * I can change my vote as much as I want

  let(:user) {FactoryGirl.create(:user)}
  let(:review) {FactoryGirl.create(:review)}

  scenario 'user cannot vote twice on a review' do
    new_review = review
    ruby_gem = review.ruby_gem
    prev_count = Vote.count

    user_signs_in(user)
    visit ruby_gems_path
    click_link ruby_gem.name

    within('.upvote') do 
      page.find('button').click 
    end
    within('.upvote') do 
      page.find('button').click 
    end
    
    expect(page).to have_content("Vote was not successfully saved.")
    expect(page).to_not have_content("Thank you for voting!")
  end 

def user_signs_in(user)
    visit '/'
    click_link 'Sign In'
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

end
