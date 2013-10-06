require 'spec_helper'

describe RubyGem do

  it { should have_valid(:name).when('Devise', 'Factory Girl') }
  it { should_not have_valid(:name).when(nil, '') }

  describe 'cannot enter already existing name' do
    let(:original) { FactoryGirl.create(:ruby_gem) }
    it { should_not have_valid(:name).when(original.name) }
  end

  describe 'reviewed by' do
    let(:review) { FactoryGirl.create(:review) }
    let(:new_user) { FactoryGirl.create(:user) }

    it 'returns true if reviewed by user' do
      expect(review.ruby_gem.reviewed_by?(review.user)).to be_true
    end

    it 'returns false if not reviewed by user' do
      expect(review.ruby_gem.reviewed_by?(new_user)).to be_false
    end
  end

end
