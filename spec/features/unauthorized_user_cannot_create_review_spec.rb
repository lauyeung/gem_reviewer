require 'spec_helper'

feature "Non-users can't submit a review", %Q{
  As an administrator of this site
  I want to ensure that unauthorized users can not create  reviews
  so that the review process can be controlled
  } do

# Acceptance Criteria
# * A user who has not been authenticated can not create a review
# * They will receive an error message if they try

  scenario "Non-author fails to submit review" do
    visit ruby_gems path
  end
end
