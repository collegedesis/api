class MembershipSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :organization_id, :membership_type_id, :approved, :display_name
end
