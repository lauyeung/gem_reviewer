FactoryGirl.define do
  factory :ruby_gem do
    sequence(:name) {|n| "Gem #{n}" }
  end

  factory :user do
    sequence(:email) {|n| "person#{n}@email.com" }
    password "password"
    password_confirmation "password"
  end

  factory :review do
    sequence(:title) {|n| "Title #{n}" }
    sequence(:content) {|n| "content #{n}" }
    rating 5
    association :user
    association :ruby_gem
  end
end
