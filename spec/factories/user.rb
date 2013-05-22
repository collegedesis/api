FactoryGirl.define do
  factory :user do
    full_name "valid name"
    email Faker::Internet.email
    password "somepass"
  end
end