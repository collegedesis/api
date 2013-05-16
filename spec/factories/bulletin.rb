FactoryGirl.define do

  factory :user do
    full_name "valid name"
    email Faker::Internet.email
    password "somepass"
  end

  factory :bulletin do
    bulletin_type 1
    title "Some cool title"
    body "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a ty"
    user
  end
end