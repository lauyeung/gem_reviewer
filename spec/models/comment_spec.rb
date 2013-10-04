require 'spec_helper'

describe Comment do
  it { should have_valid(:comment_content).when('Yes!','no way')}
  it { should_not have_valid(:comment_content).when(nil,'')}

  it { should have_valid(:review).when(Review.new)}
  it { should_not have_valid(:review).when(nil)}

  it { should have_valid(:user).when(User.new)}
  it { should_not have_valid(:user).when(nil)}

  it { should belong_to(:user)}
  it { should belong_to(:review)}
end
