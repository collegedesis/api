class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :avatar_url
  attribute :membership_ids, key: :memberships
  attribute :bulletin_ids, key: :bulletins
end