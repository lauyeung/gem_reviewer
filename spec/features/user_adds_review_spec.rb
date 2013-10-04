require 'spec_helper'

feature "user adds review", %Q{
  As a registered and logged-in user
  I want to add a review for a gem
  So that I can tell people what I think of that gem
} do

# Acceptance Criteria
#
# * I have to be signed in to write a review
# * I can write a review for a specific gem
# * I can only review a gem once
# * I can edit my review
# * I can delete my review

  scenario "user successfully adds review" do
    user = FactoryGirl.create(:user)
    newgem = FactoryGirl.create(:ruby_gem)
    prev_count = newgem.review.count
    user_signs_in(user)
    visit ruby_gems_path
    click_link newgem
    click_link "Add New Review"
    fill_in "Rating", with: 7
    fill_in "Title", with: "Awesome Gem"
    fill_in "Content", with: "It's Awesome"
    click_button "Add Review"

    expect(page).to have_content("Thanks for your Review")
    expect(newgem.review.count).to eql(prev_count + 1)
    expect(page).to have_content("Add New Gem")
  end

  scenario "user fails to add review" do
    user = FactoryGirl.create(:user)
    newgem = FactoryGirl.create(:ruby_gem)
    prev_count = newgem.review.count
    user_signs_in(user)
    visit ruby_gems_path
    click_link newgem
    click_link "Add New Review"
    click_button "Add Review"

    expect(page).to_not have_content("Thanks for your Review")
    expect(newgem.review.count).to eql(prev_count)
    expect(page).to have_content("can't be blank")
  end

  scenario "user tries to review same gem again" do
    user = FactoryGirl.create(:user)
    newgem = FactoryGirl.create(:ruby_gem)
    user_signs_in(user)
    create_review(newgem)
    prev_count = newgem.review.count
    create_review(newgem)

    expect(newgem.review.count).to eql(prev_count)
    expect(page).to have_content("You can only review a Gem once")
    expect(page).to_not have_content("Thanks for your Review")
  end

  scenario "user edits review" do
    new_content = "It's really Awesome"
    user = FactoryGirl.create(:user)
    newgem = FactoryGirl.create(:ruby_gem)
    user_signs_in(user)
    create_review(newgem)
    content = newgem.content
    visit edit_review_path
    fill_in "Rating", with: 6
    fill_in "Title", with: ""
    fill_in "Content", with: new_content

    expect(page).to have_content("You successfully updated your review")
    expect(content).to eql(new_content)
  end

  scenario "non-author fails to edit review" do
    user = FactoryGirl.create(:user)
    newgem = FactoryGirl.create(:ruby_gem)
    review = FactoryGirl.create(:review)
    user_signs_in(user)
    visit edit_review_path

    expect(page).to have_content("Only the author can edit this review")
    expect(page).to have_content("List of Reviews")
  end

  scenario "user deletes review" do
    user = FactoryGirl.create(:user)
    newgem = FactoryGirl.create(:ruby_gem)
    user_signs_in(user)
    create_review(newgem)
    prev_count = newgem.review.count
    click_link "Destroy"
    expect(newgem.review.count).to eql(prev_count - 1)
    expect(page).to have_content("Your review has been deleted")
  end

  scenario "non-author fails to destroy or update review" do
    user = FactoryGirl.create(:user)
    newgem = FactoryGirl.create(:ruby_gem)
    review = FactoryGirl.create(:review)
    user_signs_in(user)
    visit edit_review_path
    expect(page).to_not have_content("Destroy")
    expect(page).to_not have_content("Update")
  end

  scenario "user views a list of reviews" do
    reviews = FactoryGirl.create_list(:review, 3)

    visit reviews_path
    reviews.each do |review|
      expect(page).to have_content(review.ruby_gem.name)
    end

    expect(page).to have_content("List of Reviews")
  end
  def create_review(a_gem)
    visit ruby_gems_path
    click_link a_gem
    click_link "Add New Review"
    fill_in "Rating", with: 7
    fill_in "Title", with: "Awesome Gem"
    fill_in "Content", with: "It's Awesome"
    click_button "Add Review"
  end
end


