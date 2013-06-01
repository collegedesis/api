FactoryGirl.define do
  sequence(:email) { |n| "#{n}fake@fake.com" }
  factory :user do
    full_name "valid name"
    email
    password "somepass"
  end

  factory :approved_user, parent: :user do
    after(:create)  { |u| u.stub(:approved?).and_return true }
    after(:build)   { |u| u.stub(:approved?).and_return true }
  end
end