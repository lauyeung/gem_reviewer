require 'spec_helper'


feature 'user adds gem', %Q{
  As an authenticated user
  I want to add a Gem
  So that is can be reviewed
  } do

  # ACCEPTANCE CRITERIA
  # * Added Gem must have a name
  # * An error message is received if information is invalid
  # * A message is received if gem is successfully added
  # * An error message is received if gem already exists

  scenario 'valid information is provided' do
    visit new_ruby_gem_path
    prev_count = RubyGem.count
    fill_in 'Name', with: 'Devise'
    click_button 'Add Gem'
    expect(RubyGem.count).to eql(prev_count + 1)
    expect(page).to have_content('Gem successfully added!')
  end

  scenario 'invalid information is provided' do
    visit new_ruby_gem_path
    prev_count = RubyGem.count
    click_button 'Add Gem'
    expect(RubyGem.count).to eql(prev_count)
    expect(page).to have_content("can't be blank")
  end

  scenario 'try to add gem that already exists' do
    original = FactoryGirl.create(:ruby_gem)
    visit new_ruby_gem_path
    prev_count = RubyGem.count
    fill_in 'Name', with: original.name
    click_button 'Add Gem'
    expect(RubyGem.count).to eql(prev_count)
    expect(page).to have_content('already exists')
  end



end
