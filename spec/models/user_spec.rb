require 'spec_helper'

describe User do
  it { should have_valid(:email).when("user@example.com", "user.me@example.then.com")}
  it { should_not have_valid(:email).when(nil, "") }

  it { should have_valid(:password).when("password", "12345678")}
  it { should_not have_valid(:password).when(nil, "", "the") }

  it "should have matching password and password confirmations" do
    user = User.new
    user.password = "password"
    user.password_confirmation = "different"

    expect(user).not_to be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end


end
