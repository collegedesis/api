FactoryGirl.define do
  sequence(:email) { |n| "#{n}fake@fake.com" }
  sequence(:username) { |n| "user #{n}"}

  factory :user do
    full_name "valid name"
    username
    email
    password "secret"
    password_confirmation "secret"
  end

  factory :approved_user, parent: :user do
    after(:create)  { |u| u.stub(:approved?).and_return true }
    after(:build)   { |u| u.stub(:approved?).and_return true }
  end
end