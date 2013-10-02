require 'spec_helper'


feature 'view all gems', %Q{
  As an authenticated user
  I want to view a list of all the gems
  So I can see what gems have been reviewed
  } do

  # ACCEPTANCE CRITERIA
  # * See a list of all gems that have been added

  scenario 'visit page with list of all gems' do
    gems = FactoryGirl.create_list(:ruby_gem, 3)

    visit ruby_gems_path
    gems.each do |gem|
      expect(page).to have_content(gem.name)
    end
  end

end
