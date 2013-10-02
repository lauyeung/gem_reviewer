
FactoryGirl.define do
  factory :ruby_gem do
    sequence(:name) {|n| "Gem #{n}" }
  end
end

FactoryGirl.define do
  factory :user do
    email "tomcorley@gmail.com"
    password "password"
    password_confirmation "password"
  end
end
