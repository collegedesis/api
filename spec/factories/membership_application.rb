FactoryGirl.define do

  factory :membership_application do
    association :user
    association :organization
    membership_type_id 1
  end

  factory :pending_application, parent: :membership_application do
    application_status_id APP_STATUS_PENDING
  end

  factory :approved_application, parent: :membership_application do
    application_status_id APP_STATUS_APPROVED
  end

  factory :unapproved_application, parent: :membership_application do
    application_status_id APP_STATUS_REJECTED
  end

end