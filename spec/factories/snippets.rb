FactoryGirl.define do
  factory :snippet do
    sequence(:name) { |n| "snippet#{n}" }
    content "echo snippet"
    association :user, factory: :user 
  end
end
