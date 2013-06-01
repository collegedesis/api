FactoryGirl.define do

  factory :bulletin do
    title "Some cool title"
    association :user, factory: :approved_user
  end
  factory :bulletin_post, parent: :bulletin do
    bulletin_type 1
    body "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a ty"
  end

  factory :bulletin_link, parent: :bulletin do
    bulletin_type 2
    url "http://collegedesis.com"
    association :user, factory: :approved_user
  end

  factory :approved_bulletin, parent: :bulletin_post do
    after(:create) { |b| b.stub(:approved?) { true } }
    after(:build) { |b| b.stub(:approved?) { true } }
  end

end