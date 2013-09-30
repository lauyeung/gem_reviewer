
FactoryGirl.define do
  factory :ruby_gem do
    sequence(:name) {|n| "Gem #{n}" }
  end
end
