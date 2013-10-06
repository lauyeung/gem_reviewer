require 'spec_helper'


feature 'user adds gem', %Q{
  As an authenticated user
  I want to add a Gem
  So that is can be reviewed
  } do

  # ACCEPTANCE CRITERIA
  # * Added Gem must have a name
  # * An error message is received if information is invalid
  # * A message is received if gem is successfully saved
  # * An error message is received if gem already exists
  # * Need to be signed in to add gem

  let(:user) {FactoryGirl.create(:user)}

  scenario 'valid information is provided' do
    user_signs_in(user)
    visit new_ruby_gem_path
    prev_count = RubyGem.count
    fill_in 'Name', with: 'Devise'
    click_button 'Add Gem'
    expect(RubyGem.count).to eql(prev_count + 1)
    expect(page).to have_content('Gem successfully saved!')
  end

  scenario 'invalid information is provided' do
    user_signs_in(user)
    visit new_ruby_gem_path
    prev_count = RubyGem.count
    click_button 'Add Gem'
    expect(RubyGem.count).to eql(prev_count)
    expect(page).to have_content("can't be blank")
  end

  scenario 'try to add gem that already exists' do
    user_signs_in(user)
    original = FactoryGirl.create(:ruby_gem)
    visit new_ruby_gem_path
    prev_count = RubyGem.count
    fill_in 'Name', with: original.name
    click_button 'Add Gem'
    expect(RubyGem.count).to eql(prev_count)
    expect(page).to have_content('already exists')
  end

  scenario 'try to add gem when not signed in' do
    visit ruby_gems_path
    click_link 'Add New Gem'
    expect(page).to have_content('need to sign in or sign up')
  end

  def user_signs_in(user)
    visit '/'
    click_link 'Sign In'
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

end
