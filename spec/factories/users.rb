FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@server.com" }
    password "dddddddd"
    password_confirmation "dddddddd"
  end
end
