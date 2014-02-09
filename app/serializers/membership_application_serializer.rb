class MembershipApplicationSerializer < ApplicationSerializer
  attributes :id, :user_id, :membership_type_id, :organization_id, :application_status_id
end