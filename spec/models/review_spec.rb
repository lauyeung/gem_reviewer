require 'spec_helper'

describe Review do
  it { should have_valid(:title).when('Devise Rocks','Devise Sucks')}
  it { should_not have_valid(:title).when(nil,'')}

  it { should have_valid(:content).when('Devise is perfect','Devise is awful')}
  it { should_not have_valid(:content).when(nil,'')}

  it { should have_valid(:rating).when(5,1)}
  it { should_not have_valid(:rating).when(nil,'','foo',11,0)}

  it { should have_valid(:ruby_gem).when(RubyGem.new)}
  it { should_not have_valid(:ruby_gem).when(nil)}

  it { should have_valid(:user).when(User.new)}
  it { should_not have_valid(:user).when(nil)}

  it { should belong_to(:user)}
  it { should belong_to(:ruby_gem)}
end
