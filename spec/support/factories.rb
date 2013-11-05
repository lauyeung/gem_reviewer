FactoryGirl.define do
   factory :ruby_gem do
    sequence(:name) {|n| "Gem #{n}" }
  end

  factory :user do
    sequence(:username) {|n| "username#{n}"}
    sequence(:email) {|n| "person#{n}@email.com" }
    password "password"
    password_confirmation "password"
  end


  factory :signin do
    sequence(:username) {|n| "username#{n}"}
    password "password"
  end

  factory :review do
    sequence(:title) {|n| "Title #{n}" }
    sequence(:content) {|n| "content #{n}" }
    rating 5
    association :user
    association :ruby_gem
  end
end
