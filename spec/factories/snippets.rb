FactoryGirl.define do
  factory :snippet do
    sequence(:name) { |n| "snippet#{n}" }
    content "echo snippet"
    user "user"
  end
end
