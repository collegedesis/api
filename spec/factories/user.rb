FactoryGirl.define do
  sequence(:email) { |n| "#{n}fake@fake.com" }
  factory :user do
    full_name "valid name"
    email
    password "somepass"
  end
end