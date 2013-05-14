FactoryGirl.define do

  factory :organization do
    name "Cool org"
    email Faker::Internet.email
    association :university, :factory => :university
    association :organization_type, :factory => :organization_type
  end

  factory :university do
    name "Cool University"
    state "CA"
  end

  factory :organization_type do
    name "Some type"
    category "Some cat"
  end
end