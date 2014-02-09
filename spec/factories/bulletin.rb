FactoryGirl.define do

  factory :bulletin do
    title "Some cool title"
    association :user, factory: :approved_user
    author_id 1
    url "http://collegedesis.com"
    body "Lorem Ipsum is simply dummy text of the printing and
          typesetting industry. Lorem Ipsum has been the industry's standard dummy
          text ever since the 1500s, when an unknown printer took a galley of type
          and scrambled it to make a ty"
  end

  factory :approved_bulletin, parent: :bulletin do
    after(:create) { |b| b.stub(:approved?) { true } }
    after(:build) { |b| b.stub(:approved?) { true } }
  end

end