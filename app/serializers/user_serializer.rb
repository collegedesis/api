class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name
  attribute :membership_ids, key: :memberships
end