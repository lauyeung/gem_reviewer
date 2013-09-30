require 'spec_helper'

describe RubyGem do

  it { should have_valid(:name).when('Devise', 'Factory Girl') }
  it { should_not have_valid(:name).when(nil, '') }

  describe 'cannot enter already existing name' do
    original = FactoryGirl.create(:ruby_gem)
    it { should_not have_valid(:name).when(original.name) }
  end

end
